part of 'filter_cubit.dart';


abstract class FilterState {}

class FilterInitialState extends FilterState {}

class FilterErrorState extends FilterState {}

class FilterLoadingState extends FilterState {}

class FilterLoadedState extends FilterState {
  String year;
  List<Genre> genres;
  List<Genre> selectedGenres;

  FilterLoadedState({
    required this.year,
    required this.genres,
    required this.selectedGenres,
  });
}
