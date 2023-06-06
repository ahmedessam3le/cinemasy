import 'package:cinemasy/movie_details/presentation/widgets/movie_overview_widget.dart';
import 'package:cinemasy/movie_details/presentation/widgets/movie_title_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/const/app_strings.dart';
import '../../../core/const/app_values.dart';
import '../../../core/utils/dependency_injection.dart' as di;
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/app_progress.dart';
import '../../../core/widgets/main_widgets.dart';
import '../../../home/domain/entities/movie.dart';
import '../view_model/movie_details_cubit.dart';

class MovieDetailsDesktop extends StatelessWidget {
  final Movie movie;
  MovieDetailsDesktop({super.key, required this.movie});

  final MovieDetailsCubit _cubit = di.serviceLocator<MovieDetailsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppStrings.movie.tr()),
        bottom: appBarDivider(),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1200,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: movie.id.toString() +
                        movie.posterPath.toString() +
                        AppValues.heroPoster,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 38,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 640,
                          maxWidth: 480,
                        ),
                        child: AppNetworkImage(
                          url: AppValues.imageUrl + (movie.posterPath),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        left: 24,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MovieTitleWidget(
                            title: movie.title,
                            voteAverage: movie.voteAverage,
                          ),
                          BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
                            bloc: _cubit..getMovieDetails(movie.id),
                            builder: (BuildContext context,
                                MovieDetailsState state) {
                              if (state is MovieDetailsLoadingState) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 36),
                                  child: AppProgress(),
                                );
                              } else if (state is MovieDetailsErrorState) {
                                return const AppErrorWidget();
                              } else if (state is MovieDetailsLoadedState) {
                                return Flexible(
                                  child: MovieOverViewWidget(
                                    overview: state.movieDetails.overview,
                                  ),
                                );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),
                        ],
                      ),
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
