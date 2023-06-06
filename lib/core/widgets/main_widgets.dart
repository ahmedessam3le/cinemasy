import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../filter/presentation/views/filter_view.dart';
import '../../home/domain/entities/filter_model.dart';
import '../const/app_strings.dart';
import '../style/app_colors.dart';

PreferredSize appBarDivider() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(1),
    child: buildDivider(),
  );
}

Widget buildDivider() {
  return const Divider(
    thickness: 1,
    height: 1,
    indent: 0,
  );
}

Future<FilterModel?> showFilterBottomSheet({
  required BuildContext context,
  required FilterModel? filter,
}) async {
  final FilterModel? res = await showModalBottomSheet<FilterModel?>(
    context: context,
    isScrollControlled: true,
    clipBehavior: Clip.hardEdge,
    backgroundColor: Theme.of(context).dialogBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(22),
        topRight: Radius.circular(22),
      ),
    ),
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.9,
        child: FilterView(
          filter: filter,
        ),
      );
    },
  );
  return res;
}

Future<FilterModel?> showFilterAlertDialog({
  required BuildContext context,
  required FilterModel? filter,
}) async {
  final FilterModel? res = await showDialog<FilterModel?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        clipBehavior: Clip.hardEdge,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        content: SizedBox(
          width: 1000,
          child: FilterView(
            filter: filter,
          ),
        ),
      );
    },
  );
  return res;
}

class AppErrorWidget extends StatelessWidget {
  final bool showBack;
  final String title;
  final Color? backgroundColor;

  const AppErrorWidget({
    Key? key,
    this.showBack = false,
    this.title = AppStrings.somethingWentWrong,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  Icons.movie_filter_outlined,
                  color: AppColors.pinkAccent,
                  size: 180,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    title.tr(),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: Offstage(
              offstage: !showBack,
              child: SafeArea(
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 32.0,
                  ),
                  onPressed: context.pop,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
