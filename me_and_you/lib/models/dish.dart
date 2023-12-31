class Dish implements Comparable<Dish> {
  final int id;
  final num price;
  final String name;
  final DateTime date;
  final String category;
  final List<dynamic> allergens;
  final List<dynamic> labels;
  final NutritionInfo nutritionInfo;
  final String orderKey;

  Dish(
    this.id,
    this.price,
    this.name,
    this.date,
    this.category,
    this.allergens,
    this.labels,
    this.nutritionInfo,
    this.orderKey,
  );

  Dish.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        name = json['name'] as String,
        date = DateTime.parse(json['date']),
        category = json['category'] as String,
        allergens = json['allergens'] ?? [],
        labels = json['labels'] ?? [],
        nutritionInfo = NutritionInfo.fromJson(json['nutrition_info']),
        orderKey = json['order_key'] as String;

  @override
  int compareTo(Dish other) {
    final thisKey = orderKey.split('_').map((k) => int.parse(k)).toList();
    final otherKey =
        other.orderKey.split('_').map((k) => int.parse(k)).toList();

    return thisKey[0] == otherKey[0]
        ? thisKey[1].compareTo(otherKey[1])
        : thisKey[0].compareTo(otherKey[0]);
  }

  bool isVeggie() {
    return labels.contains('Vegan') ||
        labels.contains('Vegetarisch') ||
        labels.contains('vegan') ||
        labels.contains('vegetarisch') ||
        labels.contains('Vegetarian') ||
        labels.contains('vegetarian');
  }
}

class NutritionInfo {
  final int? kj;
  final int? kcal;
  final num? fat;
  final num? carb;
  final num? protein;
  final num? sodium;

  NutritionInfo(
    this.kj,
    this.kcal,
    this.fat,
    this.carb,
    this.protein,
    this.sodium,
  );

  NutritionInfo.fromJson(Map<String, dynamic> json)
      : kj = json['kj'],
        kcal = json['kcal'],
        fat = json['fat'],
        carb = json['carb'],
        protein = json['protein'],
        sodium = json['sodium'];
}
