import '../../domain/repositories/cinemasy_repository.dart';
import '../data_sources/cinemasy_remote_data_source.dart';
import '../models/genre_model.dart';
import '../models/movie_details_model.dart';
import '../models/movie_model.dart';

class CinemasyRepositoryImpl implements CinemasyRepository {
  final CinemasyRemoteDataSource cinemasyRemoteDataSource;

  CinemasyRepositoryImpl({required this.cinemasyRemoteDataSource});
  @override
  Future<List<MovieModel>> filterMovies({
    String? withGenres,
    String? sortBy,
    int? year,
    int? page,
  }) async {
    return await cinemasyRemoteDataSource.filterMovies(
        withGenres: withGenres, sortBy: sortBy, year: year, page: page);
  }

  @override
  Future<List<GenreModel>> getGenres() async {
    return await cinemasyRemoteDataSource.getGenres();
  }

  @override
  Future<MovieDetailsModel> getMovieDetails({int? movieId}) async {
    return await cinemasyRemoteDataSource.getMovieDetails(movieId: movieId);
  }

  @override
  Future<List<MovieModel>> getMovies({int? page, String? sortBy}) async {
    return await cinemasyRemoteDataSource.getMovies(page: page, sortBy: sortBy);
  }

  @override
  Future<List<MovieModel>> searchForMovie({int? page, String? query}) async {
    return await cinemasyRemoteDataSource.searchForMovie(
        page: page, query: query);
  }
}
