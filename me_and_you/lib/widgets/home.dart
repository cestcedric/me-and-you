import 'package:flutter/material.dart';
import 'package:me_and_you/models/dish.dart';
import 'package:me_and_you/state/app_state.dart';
import 'package:me_and_you/utils/index.dart';
import 'package:me_and_you/widgets/dish_card.dart';
import 'package:me_and_you/widgets/daily_menu.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // styles
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final titleStyle =
        theme.textTheme.displaySmall!.copyWith(color: colorScheme.primary);

    // data
    var appState = context.watch<AppState>();

    var validFrom = appState.validFrom;
    var validTo = appState.validTo;
    var validityPeriod = validTo.difference(validFrom).inDays + 1;
    var location = appState.location;
    var menu = appState.menu;
    var initialized = appState.initialized;

    return SafeArea(
      child: initialized
          ? Container(
              color: colorScheme.background,
              // padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                      // title: Text('Speiseplan $location', style: titleStyle),
                      pinned: false,
                      stretch: true,
                      onStretchTrigger: appState.update,
                      backgroundColor: colorScheme.background,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text('Speiseplan $location', style: titleStyle),
                        titlePadding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        background: DecoratedBox(
                          position: DecorationPosition.foreground,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: colorScheme.outlineVariant))),
                        ),
                      )),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var date = validFrom.add(Duration(days: index));

                        return DailyMenu(
                          key: Key(dateToDashedString(date)),
                          date: date,
                          dishes: menu.isNotEmpty
                              ? buildDailyMenu(
                                  menu[dateToDashedString(date)] ?? [])
                              : buildDailyMenu([]),
                        );
                      },
                      childCount: validityPeriod,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              color: colorScheme.background,
              child: Column(children: [LinearProgressIndicator()]),
            ),
    );
  }

  Wrap buildDailyMenu(List<Dish> menu) {
    menu.sort();

    return Wrap(
      children: menu.map((dish) => DishCard(dish: dish)).toList(),
    );
  }
}
