import 'package:equatable/equatable.dart';
import 'package:nutrilens/features/add_meal/data/models/user_model.dart';

enum AddMealStatus { initial, loading, success, error }

class AddMealState extends Equatable {
  final AddMealStatus status;
  final List<MealModel> meals;
  final String? errorMessage;

  const AddMealState({
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

  @override
  List<Object?> get props => [status, meals, errorMessage];
}