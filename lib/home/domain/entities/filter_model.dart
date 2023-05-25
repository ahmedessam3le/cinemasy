import 'package:cinemasy/home/domain/entities/genre.dart';

class FilterModel {
  String year;
  List<Genre> selectedGenres;

  FilterModel({
    required this.year,
    required this.selectedGenres,
  });
}
