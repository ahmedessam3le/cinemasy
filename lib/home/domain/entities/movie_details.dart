import 'package:cinemasy/home/domain/entities/genre.dart';
import 'package:cinemasy/home/domain/entities/production_company.dart';
import 'package:cinemasy/home/domain/entities/production_country.dart';
import 'package:cinemasy/home/domain/entities/spoken_language.dart';

class MovieDetails {
  final bool isAdult, isVideo;
  final String backdropPath,
      homepage,
      imdbId,
      originalLanguage,
      originalTitle,
      overview,
      posterPath,
      releaseDate,
      status,
      tagline,
      title;
  final int budget, id, revenue, runtime, voteCount;
  final List<Genre> genres;
  final double popularity, voteAverage;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<SpokenLanguage> spokenLanguages;

  MovieDetails({
    required this.isAdult,
    required this.isVideo,
    required this.backdropPath,
    required this.homepage,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.status,
    required this.tagline,
    required this.title,
    required this.budget,
    required this.id,
    required this.revenue,
    required this.runtime,
    required this.voteCount,
    required this.genres,
    required this.popularity,
    required this.voteAverage,
    required this.productionCompanies,
    required this.productionCountries,
    required this.spokenLanguages,
  });
}
