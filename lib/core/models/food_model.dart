import 'package:nutrilens/features/add_meal/data/models/food_item_model.dart';

class FoodModel {
  final String id;
  final DateTime createdAt;
  final NutritionModel nutrition;
  final String mealType;
  final List<FoodItemModel> ingredients;

  const FoodModel({
    required this.id,
    required this.createdAt,
    required this.mealType,
    required this.nutrition,
    required this.ingredients,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
    id: json['id'] ?? '',
    createdAt: DateTime.parse(json['created_at']),
    mealType: json['meal_type'] ?? '',
    nutrition: NutritionModel.fromJson(json['nutrition'] ?? {}),
    ingredients: (json['ingredients'] as List<dynamic>)
        .map((e) => FoodItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  FoodModel copyWith({
    String? id,
    DateTime? createdAt,
    String? mealType,
    NutritionModel? nutrition,
    List<FoodItemModel>? ingredients,
  }) => FoodModel(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    mealType: mealType ?? this.mealType,
    nutrition: nutrition ?? this.nutrition,
    ingredients: ingredients ?? this.ingredients,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt.toIso8601String(),
    'meal_type': mealType,
    'nutrition': nutrition.toJson(),
    'ingredients': ingredients.map((e) => e.toJson()).toList(),
  };
}

class NutritionModel {
  final num calories;
  final num protein;
  final num carbs;
  final num fats;

  const NutritionModel({
    this.calories = 0,
    this.protein = 0,
    this.carbs = 0,
    this.fats = 0,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> json) => NutritionModel(
    calories: json['calories'] ?? 0,
    protein: json['protein'] ?? 0,
    carbs: json['carbs'] ?? 0,
    fats: json['fats'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'calories': calories,
    'protein': protein,
    'carbs': carbs,
    'fats': fats,
  };
}
