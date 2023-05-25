import 'package:cinemasy/home/data/models/genre_model.dart';
import 'package:cinemasy/home/data/models/production_company_model.dart';
import 'package:cinemasy/home/data/models/production_country_model.dart';
import 'package:cinemasy/home/data/models/spoken_language_model.dart';
import 'package:cinemasy/home/domain/entities/movie.dart';

class MovieModel extends Movie {
  List<GenreModel>? genresModel;
  List<ProductionCompanyModel>? productionCompanyModel;
  List<ProductionCountryModel>? productionCountryModel;
  List<SpokenLanguageModel>? spokenLanguageModel;
  MovieModel({
    required super.isAdult,
    required super.isVideo,
    required super.backdropPath,
    required super.homepage,
    required super.imdbId,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.posterPath,
    required super.releaseDate,
    required super.status,
    required super.tagline,
    required super.title,
    required super.budget,
    required super.id,
    required super.revenue,
    required super.runtime,
    required super.voteCount,
    required this.genresModel,
    required super.popularity,
    required super.voteAverage,
    required this.productionCompanyModel,
    required this.productionCountryModel,
    required this.spokenLanguageModel,
  }) : super(
          genres: genresModel!,
          productionCompanies: productionCompanyModel!,
          productionCountries: productionCountryModel!,
          spokenLanguages: spokenLanguageModel!,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      isAdult: json['adult'],
      backdropPath: json['backdrop_path'],
      budget: json['budget'],
      genresModel: List<GenreModel>.from(
        json['genres'].map(
          (element) => GenreModel.fromJson(element),
        ),
      ),
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdb_id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      productionCompanyModel: List<ProductionCompanyModel>.from(
        json['production_companies'].map(
          (element) => ProductionCompanyModel.fromJson(element),
        ),
      ),
      productionCountryModel: List<ProductionCountryModel>.from(
        json['production_countries'].map(
          (element) => ProductionCountryModel.fromJson(element),
        ),
      ),
      releaseDate: json['release_date'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguageModel: List<SpokenLanguageModel>.from(
        json['spoken_languages'].map(
          (element) => SpokenLanguageModel.fromJson(element),
        ),
      ),
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      isVideo: json['video'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = isAdult;
    data['backdrop_path'] = backdropPath;
    data['budget'] = budget;
    data['genres'] = genresModel!.map((v) => v.toJson()).toList();
    data['homepage'] = homepage;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['production_companies'] =
        productionCompanyModel!.map((v) => v.toJson()).toList();
    data['production_countries'] =
        productionCountryModel!.map((v) => v.toJson()).toList();
    data['release_date'] = releaseDate;
    data['revenue'] = revenue;
    data['runtime'] = runtime;
    data['spoken_languages'] =
        spokenLanguageModel!.map((v) => v.toJson()).toList();
    data['status'] = status;
    data['tagline'] = tagline;
    data['title'] = title;
    data['video'] = isVideo;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
