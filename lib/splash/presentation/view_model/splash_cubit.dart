import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/app_utils.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoadingState());

  void init(void Function() goHome) {
    AppUtils.futureDelayed(milliseconds: 2500);
    goHome();
  }
}
