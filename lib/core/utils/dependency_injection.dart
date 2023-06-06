import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import '../../filter/presentation/view_model/filter_cubit.dart';
import '../../home/data/data_sources/cinemasy_local_data_source.dart';
import '../../home/data/data_sources/cinemasy_remote_data_source.dart';
import '../../home/data/repositories/cinemasy_repository_impl.dart';
import '../../home/domain/repositories/cinemasy_repository.dart';
import '../../home/presentation/view_model/home_cubit.dart';
import '../../movie_details/presentation/view_model/movie_details_cubit.dart';
import '../../splash/presentation/view_model/splash_cubit.dart';
import '../network/dio_manager.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // 1 - Features
  // a) ViewModels
  serviceLocator.registerFactory(
    () => SplashCubit(),
  );

  serviceLocator.registerFactory(
    () => HomeCubit(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => MovieDetailsCubit(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => FilterCubit(
      repository: serviceLocator(),
    ),
  );

  // b) Use Cases

  // c) Repositories
  serviceLocator.registerLazySingleton<CinemasyRepository>(
    () => CinemasyRepositoryImpl(
      cinemasyRemoteDataSource: serviceLocator(),
    ),
  );

  // d) Data Sources
  serviceLocator.registerLazySingleton<CinemasyLocalDataSource>(
    () => CinemasyLocalDataSourceImpl(),
  );

  serviceLocator.registerLazySingleton<CinemasyRemoteDataSource>(
    () => CinemasyRemoteDataSourceImpl(
      dioManager: serviceLocator(),
    ),
  );

  // 2 - Core

  // 3 - External

  serviceLocator.registerLazySingleton<DioManager>(() => DioManager());
  serviceLocator.registerFactory<Connectivity>(() => Connectivity());
}
