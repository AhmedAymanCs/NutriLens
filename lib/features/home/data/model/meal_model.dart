import 'package:cloud_firestore/cloud_firestore.dart';

class MealModel {
  final String? id; 
  final String foodName;
  final String mealType; 
  final bool isEaten; 
  final double quantity;
  final String unit;
  final int calories;
  final int carbs;
  final int protein;
  final int fat;
  final String imageUrl;
  final DateTime timestamp;

  MealModel({
    this.id,
    required this.foodName,
    required this.quantity,
    required this.unit,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.imageUrl,
    required this.timestamp, required this.mealType, required this.isEaten,
  });

  factory MealModel.fromFirestore(Map<String, dynamic> json, String documentId) {
    return MealModel(
      id: documentId,
      foodName: json['foodName'] ?? '',
      mealType: json['mealType'] ?? '',
      isEaten: json['isEaten'] ?? false,
      quantity: (json['quantity'] ?? 0),
      unit: json['unit'] ?? '',
      calories: json['calories'] ?? 0,
      carbs: json['carbs'] ?? 0,
      protein: json['protein'] ?? 0,
      fat: json['fat'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodName': foodName,
      'mealType': mealType,
      'isEaten': isEaten,
      'quantity': quantity,
      'unit': unit,
      'calories': calories,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'imageUrl': imageUrl,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}