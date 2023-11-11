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
    var appState = context.watch<AppState>();

    var validFrom = appState.validFrom;
    var validTo = appState.validTo;
    var validityPeriod = validTo.difference(validFrom).inDays + 1;
    var location = appState.location;
    var menu = appState.menu;

    // TODO: add sliver app bar

    // TODO: autoscroll to current date

    return SafeArea(
      child: appState.initialized
          ? Container(
              color: Theme.of(context).colorScheme.background,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: validityPeriod,
                itemBuilder: (context, index) {
                  var date = validFrom.add(Duration(days: index));

                  return DailyMenu(
                    key: Key(dateToDashedString(date)),
                    date: date,
                    dishes: menu.isNotEmpty
                        ? buildDailyMenu(menu[dateToDashedString(date)] ?? [])
                        : buildDailyMenu([]),
                  );
                },
              ),
            )
          : Container(
              color: Theme.of(context).colorScheme.background,
              child: Column(children: [LinearProgressIndicator()]),
            ),
    );
  }

  Wrap buildDailyMenu(List<Dish> menu) {
    return Wrap(
      children: menu.map((dish) => DishCard(dish: dish)).toList(),
    );
  }
}
