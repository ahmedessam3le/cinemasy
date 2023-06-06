import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/pagination_scroll_controller.dart';
import '../../../core/enums/home_view_enum.dart';
import '../../domain/entities/filter_model.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/cinemasy_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CinemasyRepository repository;
  HomeCubit({required this.repository}) : super(HomeInitialState()) {
    init();
  }

  late PaginationScrollController scrollController;
  HomeViewEnum viewType = HomeViewEnum.main;
  bool stopPagination = false;
  int page = 1;
  Timer? _searchTimer;
  String query = '';
  List<Movie> movies = [];
  FilterModel? filterModel;
  int? filterYear;
  String? filterGenres;

  Future<List<Movie>> getMovies() async {
    return await repository.getMovies(page: page);
  }

  void fetchMovies([type = HomeViewEnum.main]) async {
    if (type != HomeViewEnum.main) {
      emit(MoviesLoadingState());
    } else if (page == 1) {
      emit(HomeLoadingState());
    } else {
      emit(HomeLoadedState(
        movies: movies,
        scrollController: scrollController,
        filterModel: filterModel,
        isLoaded: true,
      ));
    }

    final loadedMovies = await getMovies();
    stopPagination = loadedMovies.isEmpty;
    movies.addAll(loadedMovies);
    emit(HomeLoadedState(
      movies: movies,
      scrollController: scrollController,
      filterModel: filterModel,
      isLoaded: false,
    ));
  }

  Future<void> getStartMovies() async {
    final loadedMovies = await getMovies();
    stopPagination = loadedMovies.isEmpty;
    movies.addAll(loadedMovies);
  }

  void getMoviesByQuery(String query) async {
    if (page == 1) {
      emit(HomeLoadingState());
    } else {
      emit(HomeLoadedState(
        movies: movies,
        scrollController: scrollController,
        filterModel: filterModel,
        isLoaded: true,
      ));
    }

    final loadedMovies =
        await repository.searchForMovie(page: page, query: query);
    stopPagination = loadedMovies.isEmpty;
    movies.addAll(loadedMovies);
    emit(HomeLoadedState(
      movies: movies,
      scrollController: scrollController,
      filterModel: filterModel,
      isLoaded: false,
    ));
  }

  void searchForMovie(String query) {
    filterModel = null;
    if (query.isEmpty) {
      resetSearchFilter();
    } else {
      if (this.query != query) {
        this.query = query;
        viewType = HomeViewEnum.search;
        if (_searchTimer?.isActive ?? false) {
          _searchTimer?.cancel();
        }
        _searchTimer = Timer(
          const Duration(seconds: 1),
          () async {
            if (this.query.isNotEmpty) {
              clearMovies();
              getMoviesByQuery(this.query);
            }
          },
        );
      }
    }
  }

  void setFilter() {
    int? year = int.tryParse(filterModel!.year);
    if (year != null) {
      if (year < 1920 || year > DateTime.now().year) {
        year = null;
      }
    }

    List<String> genresString = [];
    for (Genre genre in filterModel!.selectedGenres) {
      genresString.add(genre.id.toString());
    }

    final String withGenres =
        genresString.toString().replaceAll('[', '').replaceAll(']', '');

    filterYear = year;
    filterGenres = withGenres;
  }

  void applyFilter({
    FilterModel? filterModel,
    bool apply = false,
    int? page,
  }) async {
    if (apply) {
      this.page = 1;
      this.filterModel = filterModel;
    }
    if (this.page == 1) {
      emit(MoviesLoadingState());
      clearMovies();
      query = '';
      setFilter();
      viewType = HomeViewEnum.filter;
    } else {
      emit(
        HomeLoadedState(
          movies: movies,
          scrollController: scrollController,
          filterModel: filterModel,
          isLoaded: true,
        ),
      );
    }

    final loadedMovies = await repository.filterMovies(
      year: filterYear,
      withGenres: filterGenres,
      page: page,
    );
    stopPagination = loadedMovies.isEmpty;
    movies.addAll(loadedMovies);
    emit(
      HomeLoadedState(
        movies: movies,
        scrollController: scrollController,
        filterModel: filterModel,
        isLoaded: false,
      ),
    );
  }

  void resetSearchFilter() {
    query = '';
    filterModel = null;
    viewType = HomeViewEnum.main;
    clearMovies();
    fetchMovies(HomeViewEnum.search);
    emit(HomeLoadedState(
      movies: movies,
      scrollController: scrollController,
      filterModel: filterModel,
      isLoaded: false,
    ));
  }

  void clearMovies() {
    page = 1;
    movies.clear();
  }

  void initScrollController() {
    if (!stopPagination) {
      page += 1;
      getMoviesByViewType();
    }
  }

  void getMoviesByViewType() {
    switch (viewType) {
      case HomeViewEnum.main:
        fetchMovies();
        break;

      case HomeViewEnum.search:
        getMoviesByQuery(query);
        break;

      case HomeViewEnum.filter:
        applyFilter(filterModel: filterModel, page: page);
        fetchMovies();
        break;

      default:
        log('Unsupported');
        break;
    }
  }

  void init() async {
    emit(HomeLoadingState());
    scrollController = PaginationScrollController(initScrollController);
    await getStartMovies();
    emit(HomeLoadedState(
      movies: movies,
      scrollController: scrollController,
      filterModel: filterModel,
      isLoaded: false,
    ));
  }
}
