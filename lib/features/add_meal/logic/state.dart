import 'package:equatable/equatable.dart';
import 'package:nutrilens/features/add_meal/data/models/user_model.dart';

enum AddMealStatus { initial, loading, success, error }
class AddMealState extends Equatable {
  final AddMealStatus status;
  final List<MealModel> meals;
   final List<MealModel> initialMeals;
  final MealModel? selectedMeal; 
  final double quantity; 
  final String? errorMessage;

  const AddMealState({
    this.status = AddMealStatus.initial,
    this.meals = const [],
    this.initialMeals = const [],
    this.selectedMeal,
    this.quantity = 1.0,
    this.errorMessage,
  });

  AddMealState copyWith({
    AddMealStatus? status,
    List<MealModel>? meals,
     List<MealModel>? initialMeals,
    MealModel? selectedMeal,
    double? quantity,
    String? errorMessage,
  }) {
    return AddMealState(
      status: status ?? this.status,
      meals: meals ?? this.meals,
      initialMeals: initialMeals ?? this.initialMeals,
      selectedMeal: selectedMeal ?? this.selectedMeal,
      quantity: quantity ?? this.quantity,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, meals,initialMeals, selectedMeal, quantity, errorMessage];
}