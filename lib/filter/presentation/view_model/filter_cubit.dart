import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/domain/entities/filter_model.dart';
import '../../../home/domain/entities/genre.dart';
import '../../../home/domain/repositories/cinemasy_repository.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final CinemasyRepository repository;

  FilterCubit({required this.repository}) : super(FilterInitialState());
  String year = '';
  FilterModel? filter;
  List<Genre> genres = [];
  List<Genre> selectedGenres = [];
  void init(final FilterModel? filterModel) async {
    emit(FilterLoadingState());
    setFilter(filterModel);
    await getGenre();
    emit(
      FilterLoadedState(
        year: year,
        genres: genres,
        selectedGenres: selectedGenres,
      ),
    );
  }

  void setFilter(final FilterModel? filterModel) {
    if (filterModel != null) {
      year = filterModel.year;
      selectedGenres = filterModel.selectedGenres;
    }
  }

  bool applyFilter(String year) {
    if (selectedGenres.isNotEmpty) {
      filter = FilterModel(year: year, selectedGenres: selectedGenres);
      return true;
    } else {
      return false;
    }
  }

  Future<void> getGenre() async {
    genres = await repository.getGenres();
  }

  void setGenre({required Genre genre, required bool value}) {
    if (value) {
      selectedGenres.add(genre);
    } else {
      selectedGenres.removeWhere((e) => e.id == genre.id);
    }

    emit(
      FilterLoadedState(
        year: year,
        genres: genres,
        selectedGenres: selectedGenres,
      ),
    );
  }
}
