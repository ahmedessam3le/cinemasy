import 'package:flutter/material.dart';

import '../../../core/const/app_values.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/rating_widget.dart';
import '../../domain/entities/movie.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  final void Function() onTap;
  const MovieItem({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.black.withOpacity(0.1),
                    child: AspectRatio(
                      aspectRatio: 27 / 40,
                      child: Hero(
                        tag: movie.id.toString() +
                            movie.posterPath +
                            AppValues.heroPoster,
                        child: AppNetworkImage(
                          url: AppValues.imageUrl + movie.posterPath,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: RatingWidget(
                      votes: movie.voteAverage,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      movie.title,
                      style: Theme.of(context).textTheme.headline3,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
