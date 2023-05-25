import 'package:cinemasy/core/utils/app_utils.dart';
import 'package:flutter/material.dart';

class PaginationScrollController extends ScrollController {
  PaginationScrollController(Function pagination) {
    bool debounce = false;
    addListener(() async {
      if (!debounce) {
        if (position.maxScrollExtent <= position.pixels) {
          debounce = true;
          pagination();
          await AppUtils.futureDelayed(milliseconds: 500);
          debounce = false;
        }
      }
    });
  }
}
