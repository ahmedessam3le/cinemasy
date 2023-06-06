import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/domain/entities/movie_details.dart';
import '../../../home/domain/repositories/cinemasy_repository.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final CinemasyRepository repository;
  MovieDetailsCubit({required this.repository})
      : super(MovieDetailsInitialState());

  Future<void> getMovieDetails(int? movieId) async {
    if (movieId == null) {
      emit(MovieDetailsErrorState());
    } else {
      emit(MovieDetailsLoadingState());
      final MovieDetails movieDetails =
          await repository.getMovieDetails(movieId: movieId);

      emit(MovieDetailsLoadedState(movieDetails: movieDetails));
    }
  }
}
