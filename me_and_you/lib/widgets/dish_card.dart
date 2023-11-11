import 'package:flutter/material.dart';
import 'package:me_and_you/models/dish.dart';
import 'package:me_and_you/utils/hero_dialog_route.dart';
import 'package:me_and_you/utils/index.dart';

/// A card containing all info about a specific dish
/// Displays a DishDetailCard on tap
class DishCard extends StatelessWidget {
  const DishCard({
    super.key,
    required this.dish,
  });

  final Dish dish;

  @override
  Widget build(BuildContext context) {
    // styles
    final theme = Theme.of(context);
    final dishNameStyle = theme.textTheme.labelMedium!.copyWith(
      color: theme.colorScheme.primary,
    );
    final dishPriceStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.primary,
    );
    const cardBorder = BorderRadius.all(Radius.circular(12));

    // TODO: add name + price + category as icon

    return SizedBox(
      width: 320,
      height: 240,
      child: Material(
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            HeroDialogRoute(
              builder: (context) => Center(
                child: DishDetailCard(
                  dish: dish,
                ),
              ),
            ),
          ),
          customBorder: RoundedRectangleBorder(
            borderRadius: cardBorder,
          ),
          child: Hero(
            tag: dish.id.toString(),
            child: Card(
              color: theme.colorScheme.background,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: theme.colorScheme.outlineVariant,
                ),
                borderRadius: cardBorder,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dish.name, style: dishNameStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(formatPrice(dish.price), style: dishPriceStyle)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DishDetailCard extends StatelessWidget {
  const DishDetailCard({
    super.key,
    required this.dish,
  });

  final Dish dish;

  @override
  Widget build(BuildContext context) {
    // styles
    final theme = Theme.of(context);

    return SizedBox(
        width: 640, height: 480, child: Card(child: Text(dish.id.toString())));
  }
}
