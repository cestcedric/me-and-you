class Allergen {
  final int id;
  final String name;

  Allergen(this.id, this.name);

  Allergen.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String;
}
