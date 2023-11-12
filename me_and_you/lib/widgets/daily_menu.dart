import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:me_and_you/utils/index.dart';

/// A segment containing all dishes of a certain day and a sticky header
class DailyMenu extends StatelessWidget {
  final DateTime date;
  final Widget dishes;

  const DailyMenu({
    super.key,
    required this.date,
    required this.dishes,
  });

  @override
  Widget build(BuildContext context) {
    // styles
    final theme = Theme.of(context);
    final dayStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onBackground,
    );
    final dateStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onBackground.withOpacity(0.6),
      fontSize: theme.textTheme.displaySmall!.fontSize! * 0.7,
    );

    // sticky header content
    final day = TextSpan(
      text: getWeekday(date),
      style: dayStyle,
    );
    final padding = TextSpan(text: '\t' * 3);
    final dateString = TextSpan(
      text: dateToDottedString(date),
      style: dateStyle,
    );
    final headerContent = TextSpan(children: [
      day,
      padding,
      dateString,
    ]);

    return StickyHeader(
      header: Container(
          color: theme.colorScheme.background,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          alignment: Alignment.centerLeft,
          child: RichText(
            text: headerContent,
          )),
      content: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: dishes),
    );
  }
}
