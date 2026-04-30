import 'package:equatable/equatable.dart';

class MealModel extends Equatable {
  final String? id; 
  final String name;
  final String imageUrl;
  final double calories;
  final List<String> ingredients;

  const MealModel({
    this.id, 
    required this.name,
    required this.imageUrl,
    required this.calories,
    required this.ingredients,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id']?.toString(), 
      name: json['name'] ?? '',
      imageUrl: json['image'] ?? json['imageUrl'] ?? '', 
      calories: (json['calories'] ?? 0).toDouble(),
      ingredients: json['ingredients'] != null 
          ? List<String>.from(json['ingredients']) 
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'image': imageUrl, 
      'calories': calories,
      'ingredients': ingredients,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }

  @override
  List<Object?> get props => [id, name, imageUrl, calories, ingredients];
}