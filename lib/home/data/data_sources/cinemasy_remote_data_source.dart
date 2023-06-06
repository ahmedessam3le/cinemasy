import 'dart:developer';

import '../../../core/const/api_key.dart';
import '../../../core/network/dio_manager.dart';
import '../../../core/utils/app_utils.dart';
import '../models/genre_model.dart';
import '../models/movie_details_model.dart';
import '../models/movie_model.dart';

abstract class CinemasyRemoteDataSource {
  Future<List<GenreModel>> getGenres();
  Future<List<MovieModel>> getMovies({int? page, String? sortBy});
  Future<MovieDetailsModel> getMovieDetails({int? movieId});
  Future<List<MovieModel>> searchForMovie({int? page, String? query});
  Future<List<MovieModel>> filterMovies({
    String? withGenres,
    String? sortBy,
    int? year,
    int? page,
  });
}

class CinemasyRemoteDataSourceImpl implements CinemasyRemoteDataSource {
  final DioManager dioManager;

  CinemasyRemoteDataSourceImpl({required this.dioManager});
  @override
  Future<List<MovieModel>> filterMovies({
    String? withGenres,
    String? sortBy,
    int? year,
    int? page,
  }) async {
    List<MovieModel> movies = [];
    try {
      await dioManager.get(
        'discover/movie',
        parameters: {
          'api_key': apiKey,
          'language': AppUtils.getLangCode(),
          'with_genres': withGenres ?? '',
          'sort_by': sortBy ?? 'popularity.desc',
          'page': page ?? 1,
          if (year != null) 'year': year,
        },
      ).then((response) {
        movies = (response.data['results'] as List).map((element) {
          return MovieModel.fromJson(element);
        }).toList();
      });
    } catch (error) {
      log('--------------- RemoteDataSource -- filterMovies ERROR-----------------\n${error.toString()}');
      rethrow;
    }
    return movies;
  }

  @override
  Future<List<GenreModel>> getGenres() async {
    List<GenreModel> genres = [];
    try {
      await dioManager.get(
        'genre/movie/list',
        parameters: {
          'api_key': apiKey,
          'language': AppUtils.getLangCode(),
        },
      ).then((response) {
        genres = (response.data['genres'] as List).map((element) {
          return GenreModel.fromJson(element);
        }).toList();
      });
    } catch (error) {
      log('--------------- RemoteDataSource -- getGenres ERROR-----------------\n${error.toString()}');
      rethrow;
    }
    return genres;
  }

  @override
  Future<MovieDetailsModel> getMovieDetails({int? movieId}) async {
    try {
      return await dioManager.get(
        'movie/$movieId',
        parameters: {
          'api_key': apiKey,
          'language': AppUtils.getLangCode(),
        },
      ).then((response) {
        return MovieDetailsModel.fromJson(response.data);
      });
    } catch (error) {
      log('--------------- RemoteDataSource -- getMovieDetails ERROR-----------------\n${error.toString()}');
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getMovies({int? page, String? sortBy}) async {
    List<MovieModel> movies = [];
    try {
      await dioManager.get(
        'discover/movie',
        parameters: {
          'api_key': apiKey,
          'language': AppUtils.getLangCode(),
          'page': page ?? 1,
          'sort_by': sortBy ?? 'popularity.desc',
        },
      ).then((response) {
        movies = (response.data['results'] as List).map((element) {
          return MovieModel.fromJson(element);
        }).toList();
      });
    } catch (error) {
      log('--------------- RemoteDataSource -- getMovies ERROR-----------------\n${error.toString()}');
      rethrow;
    }
    return movies;
  }

  @override
  Future<List<MovieModel>> searchForMovie({int? page, String? query}) async {
    List<MovieModel> movies = [];
    try {
      await dioManager.get(
        'search/movie',
        parameters: {
          'api_key': apiKey,
          'language': AppUtils.getLangCode(),
          'page': page ?? 1,
          'query': query ?? '',
        },
      ).then((response) {
        movies = (response.data['results'] as List).map((element) {
          return MovieModel.fromJson(element);
        }).toList();
      });
    } catch (error) {
      log('--------------- RemoteDataSource -- searchForMovie ERROR-----------------\n${error.toString()}');
      rethrow;
    }
    return movies;
  }
}
