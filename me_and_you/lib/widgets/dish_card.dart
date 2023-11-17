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

  static const width = 320.0;
  static const height = 240.0;
  static const pad = 16.0;

  @override
  Widget build(BuildContext context) {
    // styles
    final theme = Theme.of(context);
    final nameStyle = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.primary,
    );
    final priceStyle = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );
    final categoryStyle = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.primary.withOpacity(0.6),
    );
    const cardBorder = BorderRadius.all(Radius.circular(12));

    // dish is vegan/vegetarian? => green + veggie tag
    final isVeggie = dish.isVeggie();
    final cardBorderColor =
        isVeggie ? Colors.green : theme.colorScheme.outlineVariant;

    return SizedBox(
      width: width,
      height: height,
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
                  color: cardBorderColor,
                ),
                borderRadius: cardBorder,
              ),
              child: Padding(
                padding: const EdgeInsets.all(pad),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dish.name, style: nameStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              VeggieTag(isVeggie: isVeggie),
                              Text(dish.category, style: categoryStyle)
                            ]),
                        Text(formatPrice(dish.price), style: priceStyle)
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
    final nameStyle = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.primary,
    );
    final priceStyle = theme.textTheme.headlineMedium!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );
    final categoryStyle = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.primary.withOpacity(0.6),
    );
    final subheaderStyle = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.secondary,
    );
    final subcontentStyle = theme.textTheme.bodyLarge!.copyWith(
      color: theme.colorScheme.tertiary,
    );
    final nutriStyle = subcontentStyle.copyWith(fontWeight: FontWeight.w100);
    const cardBorder = BorderRadius.all(Radius.circular(12));

    // dish vegan/vegetarian => green border
    final isVeggie = dish.isVeggie();
    final cardBorderColor =
        isVeggie ? Colors.green : theme.colorScheme.outlineVariant;

    final ni = dish.nutritionInfo;

    return SizedBox(
        width: 640,
        height: 480,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: cardBorderColor,
            ),
            borderRadius: cardBorder,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(dish.name, style: nameStyle),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Allergene', style: subheaderStyle),
                  SelectableText(formatList(dish.allergens),
                      style: subcontentStyle),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Merkmale', style: subheaderStyle),
                  SelectableText(formatList(dish.labels),
                      style: subcontentStyle),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Nährwerte', style: subheaderStyle),
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('Energie: ', style: subcontentStyle),
                    Text('${formatNum(ni.kj)} kJ / ${formatNum(ni.kcal)} kcal',
                        style: nutriStyle)
                  ]),
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('Fett: ', style: subcontentStyle),
                    Text('${formatNum(ni.fat)} g', style: nutriStyle)
                  ]),
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('Kohlehydrate: ', style: subcontentStyle),
                    Text('${formatNum(ni.carb)} g', style: nutriStyle)
                  ]),
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('Protein: ', style: subcontentStyle),
                    Text('${formatNum(ni.protein)} g', style: nutriStyle)
                  ]),
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('Salz: ', style: subcontentStyle),
                    Text('${formatNum(ni.sodium)} g', style: nutriStyle)
                  ])
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(dish.category, style: categoryStyle),
                      Text(formatPrice(dish.price), style: priceStyle)
                    ])
              ],
            ),
          ),
        ));
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
