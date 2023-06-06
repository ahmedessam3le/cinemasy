class Movie {
  final bool isAdult, isVideo;
  final String backdropPath,
      originalLanguage,
      originalTitle,
      overview,
      posterPath,
      releaseDate,
      title;
  final int id, voteCount;
  final num voteAverage, popularity;
  final List<int> genreIds;

  Movie({
    required this.isAdult,
    required this.isVideo,
    required this.backdropPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.id,
    required this.voteCount,
    required this.voteAverage,
    required this.popularity,
    required this.genreIds,
  });
}
