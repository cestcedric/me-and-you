import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:me_and_you/utils.dart';

class DailyMenu extends StatelessWidget {
  final DateTime date;
  final Wrap dishes;

  const DailyMenu({
    super.key,
    required this.date,
    required this.dishes,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onBackground,
    );
    final secondaryStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onBackground.withOpacity(0.6),
      fontSize: theme.textTheme.displaySmall!.fontSize! * 0.7,
    );

    final day = TextSpan(
      text: dateToString(date),
      style: primaryStyle,
    );
    final padding = TextSpan(text: '\t' * 3);
    final dateString = TextSpan(
      text: '${date.day}.${date.month}.${date.year}',
      style: secondaryStyle,
    );

    return StickyHeader(
        header: Container(
            color: theme.colorScheme.background,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(children: [
                day,
                padding,
                dateString,
              ]),
            )),
        content: dishes);
  }
}
