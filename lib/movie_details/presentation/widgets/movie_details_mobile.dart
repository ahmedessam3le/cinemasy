import 'package:cinemasy/movie_details/presentation/widgets/movie_overview_widget.dart';
import 'package:cinemasy/movie_details/presentation/widgets/movie_title_widget.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/const/app_values.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/utils/dependency_injection.dart' as di;
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/app_progress.dart';
import '../../../core/widgets/main_widgets.dart';
import '../../../home/domain/entities/movie.dart';
import '../view_model/movie_details_cubit.dart';

class MovieDetailsMobile extends StatelessWidget {
  final Movie movie;

  MovieDetailsMobile({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieDetailsCubit _cubit = di.serviceLocator<MovieDetailsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <SliverAppBar>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height / 1.4,
              floating: true,
              pinned: false,
              shadowColor: AppColors.transparent,
              iconTheme: Theme.of(context).iconTheme.copyWith(
                    color: AppColors.white,
                  ),
              leading: IconButton(
                onPressed: context.pop,
                icon: DecoratedIcon(
                  Icons.adaptive.arrow_back,
                  shadows: [
                    BoxShadow(
                      blurRadius: 30,
                      color: Theme.of(context).primaryColor.withOpacity(0.76),
                    ),
                  ],
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: movie.id.toString() +
                      movie.posterPath.toString() +
                      AppValues.heroPoster,
                  child: AppNetworkImage(
                    url: AppValues.imageUrl + (movie.posterPath),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MovieTitleWidget(
                  title: movie.title,
                  voteAverage: movie.voteAverage,
                ),
                buildDivider(),
                BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
                  bloc: _cubit..getMovieDetails(movie.id),
                  builder: (BuildContext context, MovieDetailsState state) {
                    if (state is MovieDetailsLoadingState) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 36),
                        child: AppProgress(),
                      );
                    } else if (state is MovieDetailsErrorState) {
                      return const AppErrorWidget();
                    } else if (state is MovieDetailsLoadedState) {
                      return MovieOverViewWidget(
                        overview: state.movieDetails.overview,
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
      ),
    );
  }
}
