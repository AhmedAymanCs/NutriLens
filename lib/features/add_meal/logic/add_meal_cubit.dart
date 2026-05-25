import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/core/models/food_model.dart';
import 'package:nutrilens/features/add_meal/data/models/food_item_model.dart';
import 'package:nutrilens/features/add_meal/data/repository/add_meal_repository.dart';
import 'package:nutrilens/features/add_meal/logic/add_meal_state.dart';
import 'package:uuid/uuid.dart';

class AddMealCubit extends Cubit<AddMealState> {
  final AddMealRepository addMealRepository;

  AddMealCubit(this.addMealRepository) : super(const AddMealState());

  Future<void> getFoodItems() async {
    emit(state.copyWith(status: AddMealStatus.loading));
    final result = await addMealRepository.getFoodItems();
    result.fold(
      (failure) => emit(
        state.copyWith(status: AddMealStatus.failure, errorMessage: failure),
      ),
      (foodItems) => emit(
        state.copyWith(status: AddMealStatus.success, foodItems: foodItems),
      ),
    );
  }

  void searchFoodItems(String query) {
    if (query.trim().isEmpty) {
      emit(state.copyWith(filteredFoodItems: []));
      return;
    }
    final q = query.trim().toLowerCase();
    final filtered = state.foodItems.where((item) {
      return item.name.toLowerCase().contains(q) ||
          item.nameEn.toLowerCase().contains(q);
    }).toList();
    emit(state.copyWith(filteredFoodItems: filtered));
  }

  void selectFoodItem(FoodItemModel item) {
    emit(
      state.copyWith(
        filteredFoodItems: [],
        currentFoodItem: item,
        status: AddMealStatus.success,
      ),
    );
  }

  void submitIngredient({required String name, required num grams}) {
    if (!_isValidIngredient(name)) {
      return;
    }
    final double protein =
        (state.currentFoodItem!.proteinG / AppConstants.jsonServ) * grams;
    final double carbs =
        (state.currentFoodItem!.carbsG / AppConstants.jsonServ) * grams;
    final double fat =
        (state.currentFoodItem!.fatG / AppConstants.jsonServ) * grams;
    final double calories =
        (state.currentFoodItem!.calories / AppConstants.jsonServ) * grams;
    final updated = state.currentFoodItem!.copyWith(
      servingSizeG: grams,
      proteinG: protein,
      carbsG: carbs,
      fatG: fat,
      calories: calories,
    );
    emit(
      state.copyWith(selectedFoodItems: [...state.selectedFoodItems, updated]),
    );
    calculateNutrition();
  }

  void removeIngredient(int index) {
    final updated = [...state.selectedFoodItems]..removeAt(index);
    emit(state.copyWith(selectedFoodItems: updated));
    calculateNutrition();
  }

  void updateFoodType(String? type) {
    log('in updateFoodType() type: $type');
    if (type == null) return;
    emit(state.copyWith(currentMealType: type, status: AddMealStatus.initial));
  }

  void calculateNutrition() {
    emit(
      state.copyWith(
        nutrition: NutritionModel(
          calories: state.selectedFoodItems.fold(
            0,
            (sum, item) => sum + item.calories,
          ),
          protein: state.selectedFoodItems.fold(
            0,
            (sum, item) => sum + item.proteinG,
          ),
          carbs: state.selectedFoodItems.fold(
            0,
            (sum, item) => sum + item.carbsG,
          ),
          fats: state.selectedFoodItems.fold(0, (sum, item) => sum + item.fatG),
        ),
      ),
    );
  }

  Future<void> saveSelectedMeal() async {
    emit(
      state.copyWith(
        status: AddMealStatus.loading,
        selectedMeal: FoodModel(
          mealType: state.currentMealType ?? 'Unknown',
          nutrition: NutritionModel(
            calories: state.nutrition.calories,
            protein: state.nutrition.protein,
            carbs: state.nutrition.carbs,
            fats: state.nutrition.fats,
          ),
          id: const Uuid().v4(),
          createdAt: DateTime.now(),
          ingredients: state.selectedFoodItems,
        ),
      ),
    );
    final result = await addMealRepository.saveMeal(state.selectedMeal!);
    result.fold(
      (failure) => emit(
        state.copyWith(status: AddMealStatus.failure, errorMessage: failure),
      ),
      (_) {
        emit(
          state.copyWith(
            status: AddMealStatus.saveSuccess,
            selectedFoodItems: [],
          ),
        );
        calculateNutrition();
      },
    );
  }

  bool _isValidIngredient(String value) {
    return state.foodItems.any(
      (item) =>
          item.name.toLowerCase() == value.trim().toLowerCase() ||
          item.nameEn.toLowerCase() == value.trim().toLowerCase(),
    );
  }
}
