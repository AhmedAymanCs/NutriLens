part of 'cubit.dart';

enum AddMealStatus { initial, loading, success, error, searching }

class AddMealState {
  final AddMealStatus status;
  final List<MealModel> meals;
  final String? errorMessage;

  AddMealState({
    this.status = AddMealStatus.initial,
    this.meals = const [],
    this.errorMessage,
  });

  AddMealState copyWith({
    AddMealStatus? status,
    List<MealModel>? meals,
    String? errorMessage,
  }) {
    return AddMealState(
      status: status ?? this.status,
      meals: meals ?? this.meals,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}