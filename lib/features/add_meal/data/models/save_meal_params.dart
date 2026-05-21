import 'package:nutrilens/features/add_meal/data/models/meal_model.dart';

class SaveMealParams {
  final MealModel mealModel;
  final String userId;
  final String mealType;
  final DateTime? date;

  SaveMealParams({
    required this.mealModel,
    required this.userId,
    required this.mealType,
    this.date,
  });

  SaveMealParams copyWith({
    MealModel? mealModel,
    String? userId,
    String? mealType,
    DateTime? date,
  }) => SaveMealParams(
    mealModel: mealModel ?? this.mealModel,
    userId: userId ?? this.userId,
    mealType: mealType ?? this.mealType,
    date: date ?? this.date,
  );
}
