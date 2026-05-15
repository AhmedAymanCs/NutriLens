import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilens/core/constants/app_constants.dart';

class MealModel {
  final String id; 
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
    required this.id,
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
      foodName: json[AppConstants.foodNameKey] ?? '',
      mealType: json[AppConstants.mealTypeKey] ?? '',
      isEaten: json[AppConstants.isEatenKey] ?? false,
      quantity: (json[AppConstants.quantityKey] ?? 0),
      unit: json[AppConstants.unitKey] ?? '',
      calories: json[AppConstants.caloriesKey] ?? 0,
      carbs: json[AppConstants.carbsKey] ?? 0,
      protein: json[AppConstants.proteinKey] ?? 0,
      fat: json[AppConstants.fatKey] ?? 0,
      imageUrl: json[AppConstants.imageUrlKey] ?? '',
      timestamp: json[AppConstants.timestampKey] != null 
    ? (json[AppConstants.timestampKey] as Timestamp).toDate() 
    : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.foodNameKey: foodName,
      AppConstants.mealTypeKey: mealType,
      AppConstants.isEatenKey: isEaten,
      AppConstants.quantityKey: quantity,
      AppConstants.unitKey: unit,
      AppConstants.caloriesKey: calories,
      AppConstants.carbsKey: carbs,
      AppConstants.proteinKey: protein,
      AppConstants.fatKey: fat,
      AppConstants.imageUrlKey: imageUrl,
      AppConstants.timestampKey: Timestamp.fromDate(timestamp),
    };
  }
}