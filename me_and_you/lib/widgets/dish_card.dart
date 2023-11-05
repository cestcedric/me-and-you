import 'package:flutter/material.dart';

class DishCard extends StatelessWidget {
  const DishCard({
    super.key,
    required this.dish,
  });

  // TODO: change this type to Dish
  final String dish;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primary,
    );

    // TODO: add name + price + category as icon
    // TODO: on click behaviour => show nutritional info in popup

    return Card(
      color: theme.colorScheme.background,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          dish,
          style: style,
        ),
      ),
    );
  }
}
