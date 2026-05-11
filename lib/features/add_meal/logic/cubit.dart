import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/add_meal/data/models/user_model.dart';
import 'package:nutrilens/features/add_meal/data/repository/add_repository.dart';
import 'package:nutrilens/features/add_meal/logic/state.dart';

class AddMealCubit extends Cubit<AddMealState> {
  final AddMealRepository repository;
  AddMealCubit(this.repository) : super(const AddMealState()) {
    loadDefaultMeal();
  }

 

  Future<void> loadDefaultMeal() async {
    final result = await repository.searchMeals('');

    result.fold(
      (failure) => emit(
        state.copyWith(status: AddMealStatus.error, errorMessage: failure),
      ),
      (mealsList) {
        if (mealsList.isNotEmpty) {
          selectMeal(mealsList.first);
        }
      },
    );
  }

  void searchMeals(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(meals: []));
      return;
    }

    final result = await repository.searchMeals(query);
    result.fold(
      (failure) => emit(
        state.copyWith(status: AddMealStatus.error, errorMessage: failure),
      ),
      (mealsList) => emit(state.copyWith(meals: mealsList)),
    );
  }

  void selectMeal(MealModel meal) {
    emit(state.copyWith(selectedMeal: meal, meals: []));
  }

  void updateQuantity(String qty) {
    double value = double.tryParse(qty) ?? 1.0;
    emit(state.copyWith(quantity: value));
  }

  Future<void> addNewMeal() async {
    if (state.selectedMeal == null) return;

    emit(state.copyWith(status: AddMealStatus.loading));

    final finalMeal = state.selectedMeal!.copyWith(
      calories: state.selectedMeal!.calories * state.quantity,
      carbs: state.selectedMeal!.carbs * state.quantity,
      protein: state.selectedMeal!.protein * state.quantity,
      fat: state.selectedMeal!.fat * state.quantity,
    );

    final result = await repository.addMeal(finalMeal);
    result.fold(
      (failure) => emit(
        state.copyWith(status: AddMealStatus.error, errorMessage: failure),
      ),
      (_) => emit(state.copyWith(status: AddMealStatus.success)),
    );
  }
}
