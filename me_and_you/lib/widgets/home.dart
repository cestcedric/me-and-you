import 'package:flutter/material.dart';
import 'package:me_and_you/widgets/dish_card.dart';
import 'package:me_and_you/widgets/daily_header.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();

    // TODO: read data from app state

    const menu = [
      ['beans', 'greens', 'tomatoes', 'potatoes'],
      ['1'],
      ['1'],
      ['32', '324'],
      ['34'],
      ['34']
    ];

    List<Wrap> dailyMenus = [
      buildDailyMenu(menu[0]),
      buildDailyMenu(menu[1]),
    ];

    // TODO: add sliver app bar

    return Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView.builder(
          itemCount: dailyMenus.length,
          itemBuilder: (context, index) {
            return DailyHeader(
              date: DateTime.now().add(Duration(days: index)),
              dishes: dailyMenus[index],
            );
          },
        ));
  }

  Wrap buildDailyMenu(List<String> menu) {
    return Wrap(
      children: menu.map((dish) => DishCard(dish: dish)).toList(),
    );
  }
}
