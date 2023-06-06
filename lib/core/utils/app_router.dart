import 'package:go_router/go_router.dart';

import '../../home/domain/entities/movie.dart';
import '../../home/presentation/views/home_view.dart';
import '../../movie_details/presentation/views/movie_details_view.dart';
import '../../settings/presentation/views/settings_view.dart';
import '../../splash/presentation/views/splash_view.dart';

class AppRoutes {
  static const String splashRoute = '/';
  static const String homeRoute = '/homeRoute';
  static const String movieDetailsRoute = '/movieDetailsRoute';
  static const String settingsRoute = '/settingsRoute';
}

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.splashRoute,
        builder: (context, state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: AppRoutes.homeRoute,
        builder: (context, state) {
          return const HomeView();
        },
      ),
      GoRoute(
        path: AppRoutes.movieDetailsRoute,
        builder: (context, state) {
          return MovieDetailsView(movie: state.extra as Movie);
        },
      ),
      GoRoute(
        path: AppRoutes.settingsRoute,
        builder: (context, state) {
          return const SettingsView();
        },
      ),
    ],
  );
}
