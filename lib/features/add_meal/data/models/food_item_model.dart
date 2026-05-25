class FoodItemModel {
  final int id;
  final String name;
  final String nameEn;
  final String category;
  final num servingSizeG;
  final num calories;
  final num proteinG;
  final num carbsG;
  final num fatG;
  final num fiberG;
  final num sugarG;
  final num sodiumMg;

  const FoodItemModel({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.category,
    required this.servingSizeG,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.fiberG,
    required this.sugarG,
    required this.sodiumMg,
  });

  factory FoodItemModel.fromJson(Map<String, dynamic> json) => FoodItemModel(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    nameEn: json['name_en'] ?? '',
    category: json['category'] ?? '',
    servingSizeG: json['serving_size_g'] ?? 0,
    calories: json['calories'] ?? 0,
    proteinG: json['protein_g'] ?? 0,
    carbsG: json['carbs_g'] ?? 0,
    fatG: json['fat_g'] ?? 0,
    fiberG: json['fiber_g'] ?? 0,
    sugarG: json['sugar_g'] ?? 0,
    sodiumMg: json['sodium_mg'] ?? 0,
  );
  FoodItemModel copyWith({
    int? id,
    String? name,
    String? nameEn,
    String? category,
    num? servingSizeG,
    num? calories,
    num? proteinG,
    num? carbsG,
    num? fatG,
    num? fiberG,
    num? sugarG,
    num? sodiumMg,
  }) => FoodItemModel(
    id: id ?? this.id,
    name: name ?? this.name,
    nameEn: nameEn ?? this.nameEn,
    category: category ?? this.category,
    servingSizeG: servingSizeG ?? this.servingSizeG,
    calories: calories ?? this.calories,
    proteinG: proteinG ?? this.proteinG,
    carbsG: carbsG ?? this.carbsG,
    fatG: fatG ?? this.fatG,
    fiberG: fiberG ?? this.fiberG,
    sugarG: sugarG ?? this.sugarG,
    sodiumMg: sodiumMg ?? this.sodiumMg,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'name_en': nameEn,
    'category': category,
    'serving_size_g': servingSizeG,
    'calories': calories,
    'protein_g': proteinG,
    'carbs_g': carbsG,
    'fat_g': fatG,
    'fiber_g': fiberG,
    'sugar_g': sugarG,
    'sodium_mg': sodiumMg,
  };
}
