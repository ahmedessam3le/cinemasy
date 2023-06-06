import 'package:cinemasy/core/const/app_values.dart';
import 'package:cinemasy/core/style/app_themes.dart';
import 'package:cinemasy/core/utils/app_router.dart';
import 'package:cinemasy/core/utils/dependency_injection.dart' as di;
import 'package:cinemasy/home/data/data_sources/cinemasy_local_data_source.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  di.init();
  await Hive.initFlutter();
  await di.serviceLocator<CinemasyLocalDataSource>().openBox();
  runApp(
    EasyLocalization(
      supportedLocales: AppValues.supportedLocales,
      path: AppValues.localesPath,
      fallbackLocale: AppValues.localeEN,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppValues.appName,
        theme: AppThemes.getTheme(),
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
      ),
    );
  }
}
