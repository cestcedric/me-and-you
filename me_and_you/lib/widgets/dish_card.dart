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
    final dishNameStyle = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.primary,
    );
    final dishPriceStyle = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );
    final dishCategoryStyle = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.primary.withOpacity(0.6),
    );
    const cardBorder = BorderRadius.all(Radius.circular(12));

    // vegan/vegetarian dish? => green card
    final isVeggie =
        dish.labels.contains('Vegan') || dish.labels.contains('Vegetarisch');

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
                  color: isVeggie
                      ? Colors.green
                      : theme.colorScheme.outlineVariant,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              VeggieTag(isVeggie: isVeggie),
                              Text(dish.category, style: dishCategoryStyle)
                            ]),
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

/// Detailed information about dish
/// TODO: implement
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
        width: 640, height: 480, child: Card(child: Text(dish.orderKey)));
  }
}

/// Returns tag if dish is vegan/vegetarian
class VeggieTag extends StatelessWidget {
  const VeggieTag({super.key, required this.isVeggie});

  final bool isVeggie;

  @override
  Widget build(BuildContext context) {
    return isVeggie
        ? Padding(
            padding: EdgeInsets.only(right: 8),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isVeggie ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'Veggie',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : Container();
  }
}
