class Dish {
  final int id;
  final String name;
  final DateTime date;
  final String category;
  final List<dynamic>? allergens;
  final List<dynamic>? labels;
  final NutritionInfo nutritionInfo;
  final String orderKey;

  Dish(
    this.id,
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
        name = json['name'] as String,
        date = DateTime.parse(json['date']),
        category = json['category'] as String,
        allergens = json['allergens'] as List<dynamic>,
        labels = json['labels'],
        nutritionInfo = NutritionInfo.fromJson(json['nutrition_info']),
        orderKey = json['order_key'] as String;
}

class NutritionInfo {
  final int kj;
  final int kcal;
  final num fat;
  final num carb;
  final num protein;
  final num sodium;

  NutritionInfo(
    this.kj,
    this.kcal,
    this.fat,
    this.carb,
    this.protein,
    this.sodium,
  );

  NutritionInfo.fromJson(Map<String, dynamic> json)
      : kj = json['kj'] as int,
        kcal = json['kcal'] as int,
        fat = json['fat'] as num,
        carb = json['carb'] as num,
        protein = json['protein'] as num,
        sodium = json['sodium'] as num;
}
