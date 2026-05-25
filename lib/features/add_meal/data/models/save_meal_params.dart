import 'package:nutrilens/core/models/food_model.dart';

class SaveMealParams {
  final FoodModel mealModel;
  final String userId;
  final DateTime? date;

  SaveMealParams({required this.mealModel, required this.userId, this.date});

  SaveMealParams copyWith({
    FoodModel? mealModel,
    String? userId,
    String? mealType,
    DateTime? date,
  }) => SaveMealParams(
    mealModel: mealModel ?? this.mealModel,
    userId: userId ?? this.userId,
    date: date ?? this.date,
  );
}
