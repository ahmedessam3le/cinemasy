import '../entities/genre.dart';
import '../entities/movie.dart';
import '../entities/movie_details.dart';

abstract class CinemasyRepository {
  Future<List<Genre>> getGenres();
  Future<List<Movie>> getMovies({int? page, String? sortBy});
  Future<MovieDetails> getMovieDetails({int? movieId});
  Future<List<Movie>> searchForMovie({int? page, String? query});
  Future<List<Movie>> filterMovies({
    String? withGenres,
    String? sortBy,
    int? year,
    int? page,
  });
}
