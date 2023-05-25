import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../style/app_colors.dart';

class RatingWidget extends StatelessWidget {
  final double votes;
  const RatingWidget({
    Key? key,
    required this.votes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        RatingBarIndicator(
          itemSize: 21,
          rating: (votes / 2) - 0.5,
          itemBuilder: (context, index) {
            return (index + 1) <= ((votes / 2))
                ? const Icon(
                    Icons.star,
                    color: AppColors.yellow,
                  )
                : const Icon(
                    Icons.star_border,
                    color: AppColors.yellow,
                  );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Text(
            votes.toString(),
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}
