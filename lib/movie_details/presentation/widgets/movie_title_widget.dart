import 'package:flutter/material.dart';

import '../../../core/widgets/rating_widget.dart';

class MovieTitleWidget extends StatelessWidget {
  final String? title;
  final num? voteAverage;
  const MovieTitleWidget({
    super.key,
    required this.title,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 22,
        left: 10,
        right: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title ?? '',
            style: Theme.of(context).textTheme.headline2,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: RatingWidget(
              votes: voteAverage ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
