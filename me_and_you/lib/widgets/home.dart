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

    return Container(
      color: colorScheme.background,
      child: SafeArea(
          child: initialized
              ? CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      pinned: false,
                      stretch: true,
                      onStretchTrigger: appState.update,
                      title: Center(child: Text(location, style: titleStyle)),
                      backgroundColor: colorScheme.background,
                      surfaceTintColor: colorScheme.primary,
                      flexibleSpace: FlexibleSpaceBar(
                        background: DecoratedBox(
                          position: DecorationPosition.foreground,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: colorScheme.outlineVariant),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          var date = validFrom.add(Duration(days: index));

                          return Column(children: [
                            DailyMenu(
                              key: Key(dateToDashedString(date)),
                              date: date,
                              dishes: menu.isNotEmpty
                                  ? buildDailyMenu(
                                      menu[dateToDashedString(date)] ?? [])
                                  : buildDailyMenu([]),
                            )
                          ]);
                        },
                        childCount: validityPeriod,
                      ),
                    ),
                  ],
                )
              : Column(children: [LinearProgressIndicator()])),
    );
  }

  Wrap buildDailyMenu(List<Dish> menu) {
    menu.sort();

    return Wrap(
      children: menu.map((dish) => DishCard(dish: dish)).toList(),
    );
  }
}
