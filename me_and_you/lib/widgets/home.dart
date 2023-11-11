import 'package:flutter/material.dart';
import 'package:me_and_you/entities/dish.dart';
import 'package:me_and_you/state/app_state.dart';
import 'package:me_and_you/widgets/dish_card.dart';
import 'package:me_and_you/widgets/daily_menu.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    var validFrom = appState.validFrom;
    var validTo = appState.validTo;
    var location = appState.location;
    var menu = appState.menu;

    // TODO: add sliver app bar

    // TODO: autoscroll to current date

    return Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView.builder(
          itemCount: validTo.difference(validFrom).inDays + 1,
          itemBuilder: (context, index) {
            return DailyMenu(
              date: validFrom.add(Duration(days: index)),
              dishes: menu.isNotEmpty
                  ? buildDailyMenu(menu[menu.keys.toList()[index]] ?? [])
                  : buildDailyMenu([]),
            );
          },
        ));
  }

  Wrap buildDailyMenu(List<Dish> menu) {
    return Wrap(
      children: menu.map((dish) => DishCard(dish: dish)).toList(),
    );
  }
}
