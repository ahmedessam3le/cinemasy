import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/const/app_strings.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/dependency_injection.dart' as di;
import '../view_model/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = di.serviceLocator<SplashCubit>();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.init(() => context.go(AppRoutes.homeRoute));
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/app_icon.png',
                  width: MediaQuery.of(context).size.width * 0.55,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 16,
                      start: 12,
                    ),
                    child: Text(
                      AppStrings.appName,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
