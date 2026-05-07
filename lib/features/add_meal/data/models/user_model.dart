import 'package:equatable/equatable.dart';

class MealModel extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double calories;
  final List<String> ingredients;
  final double carbs;
  final double protein;
  final double fat;

  const MealModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.calories,
    required this.ingredients,
    this.carbs = 0,
    this.protein = 0,
    this.fat = 0,
  });

  MealModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? calories,
    List<String>? ingredients,
    double? carbs,
    double? protein,
    double? fat,
  }) {
    return MealModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      calories: calories ?? this.calories,
      ingredients: ingredients ?? this.ingredients,
      carbs: carbs ?? this.carbs,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
    );
  }

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'],
      name: json['name'] ?? '',
      imageUrl: json['image'] ?? json['imageUrl'] ?? '',
      calories: (json['calories'] ?? 0).toDouble(),
      carbs: (json['carbs'] ?? 0).toDouble(),
      protein: (json['protein'] ?? 0).toDouble(),
      fat: (json['fat'] ?? 0).toDouble(),
      ingredients: json['ingredients'] != null
          ? List<String>.from(json['ingredients'])
          : [],
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl, calories, ingredients, carbs, protein, fat];
}