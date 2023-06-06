import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/const/app_strings.dart';

class MovieOverViewWidget extends StatelessWidget {
  final String? overview;
  const MovieOverViewWidget({super.key, this.overview});

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: (overview ?? '').isEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 10.0, right: 10.0),
            child: Text(
              AppStrings.description.tr(),
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 12.0, bottom: 20.0, left: 10.0, right: 10.0),
            child: Text(
              overview ?? '',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
