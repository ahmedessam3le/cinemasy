part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class MoviesLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  List<Movie> movies;
  PaginationScrollController scrollController;
  FilterModel? filterModel;
  bool isLoaded;

  HomeLoadedState({
    required this.movies,
    required this.scrollController,
    this.filterModel,
    required this.isLoaded,
  });
}

class HomeErrorState extends HomeState {}

class HomePaginationState extends HomeState {}
