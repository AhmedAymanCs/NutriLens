import 'package:equatable/equatable.dart';
import 'package:nutrilens/features/add_meal/data/models/meal_model.dart';

enum AddMealStatus { initial, loading, getSuccess, saveSuccess, failure }

class AddMealState extends Equatable {
  final AddMealStatus status;
  final List<MealModel> meals;
  final MealModel? meal;
  final String errorMessage;

  const AddMealState({
    this.status = AddMealStatus.initial,
    this.meals = const [],
    this.meal,
    this.errorMessage = '',
  });

  AddMealState copyWith({
    AddMealStatus? status,
    List<MealModel>? meals,
    MealModel? meal,
    String? mealType,
    String? errorMessage,
  }) => AddMealState(
    status: status ?? this.status,
    meals: meals ?? this.meals,
    meal: meal ?? this.meal,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, meals, meal, errorMessage];
}
