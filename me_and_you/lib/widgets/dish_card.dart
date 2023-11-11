import 'package:flutter/material.dart';
import 'package:me_and_you/entities/dish.dart';

class DishCard extends StatelessWidget {
  const DishCard({
    super.key,
    required this.dish,
  });

  final Dish dish;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryStyle = theme.textTheme.bodyLarge!.copyWith(
      color: theme.colorScheme.primary,
    );
    final secondaryStyle = theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.primary,
    );

    // TODO: add name + price + category as icon
    // TODO: on click behaviour => show nutritional info in popup (InkWell)

    return SizedBox(
      width: 320,
      height: 240,
      child: Card(
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
            dish.name + ' ' + (dish.nutritionInfo.kcal?.toString() ?? ''),
            style: primaryStyle,
          ),
        ),
      ),
    );
  }
}
