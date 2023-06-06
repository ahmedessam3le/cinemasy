import 'package:flutter/material.dart';

import '../../../home/domain/entities/movie.dart';
import '../widgets/movie_details_desktop.dart';
import '../widgets/movie_details_mobile.dart';

class MovieDetailsView extends StatelessWidget {
  final Movie movie;
  const MovieDetailsView({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 800) {
          return MovieDetailsMobile(
            movie: movie,
          );
        } else {
          return MovieDetailsDesktop(
            movie: movie,
          );
        }
      },
    );
  }
}
