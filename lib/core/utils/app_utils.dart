import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:overlay_support/overlay_support.dart';

import '../const/app_values.dart';

class AppUtils {
  static void errorToast({
    required String? code,
    required String? message,
  }) {
    toast(
      getClearName(code, message, comma: true),
      duration: const Duration(milliseconds: 1400),
    );
  }

  static bool isApple() {
    return defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  static bool isMobile() {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  static double doubleParser(dynamic data) {
    final double? doubleResult = double.tryParse(data.toString());
    if (doubleResult != null) {
      return doubleResult;
    } else {
      return 0.0;
    }
  }

  static String getClearName(String? firstName, String? lastName,
      {bool comma = false}) {
    return (firstName ?? '') +
        (firstName == null
            ? ''
            : firstName.isEmpty
                ? ''
                : comma
                    ? lastName == null
                        ? ''
                        : lastName.isEmpty
                            ? ''
                            : ', '
                    : ' ') +
        (lastName ?? '');
  }

  static String getLangCode() {
    try {
      switch (window.locale.languageCode) {
        case AppValues.langCodeAr:
          return AppValues.langCodeAr;
        case AppValues.langCodeEn:
          return AppValues.langCodeEn;
        default:
          return AppValues.langCodeBasic;
      }
    } catch (e) {
      return AppValues.langCodeBasic;
    }
  }

  static Future<void> futureDelayed({int milliseconds = 1000}) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
}
