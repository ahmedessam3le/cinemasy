part of 'movie_details_cubit.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitialState extends MovieDetailsState {}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsLoadedState extends MovieDetailsState {
  final MovieDetails movieDetails;

  MovieDetailsLoadedState({required this.movieDetails});
}

class MovieDetailsErrorState extends MovieDetailsState {}
