import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/constants/app_constants.dart';
import 'package:nutrilens/features/add_meal/data/models/food_item_model.dart';
import 'package:nutrilens/features/add_meal/data/models/meal_model.dart';
import 'package:nutrilens/features/add_meal/data/repository/add_meal_repository.dart';
import 'package:nutrilens/features/add_meal/logic/add_meal_state.dart';

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
        state.copyWith(status: AddMealStatus.getSuccess, foodItems: foodItems),
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
    emit(state.copyWith(filteredFoodItems: [], currentFoodItem: item));
    log(state.currentFoodItem!.name);
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
    if (type == null) return;
    emit(state.copyWith(currentMealType: type));
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

  void saveSelectedFoodItem(FoodItemModel item) {
    if (_isValidIngredient(item.name)) {
      return;
    }
  }

  bool _isValidIngredient(String value) {
    return state.foodItems.any(
      (item) =>
          item.name.toLowerCase() == value.trim().toLowerCase() ||
          item.nameEn.toLowerCase() == value.trim().toLowerCase(),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////
  Future<void> getMealElements() async {
    emit(state.copyWith(status: AddMealStatus.loading));
    final result = await addMealRepository.getMealElements();
    result.fold(
      (failure) => emit(
        state.copyWith(status: AddMealStatus.failure, errorMessage: failure),
      ),
      (meals) =>
          emit(state.copyWith(status: AddMealStatus.initial, meals: meals)),
    );
  }

  void updateMealName(String name) {
    emit(state.copyWith(currentMealName: name));
  }

  void updateMealType(String? type) {
    emit(state.copyWith(currentMealType: type));
  }

  void updateIngredientName(int index, String name) {
    final updated = [...state.currentIngredients];
    updated[index] = updated[index].copyWith(name: name);
    emit(state.copyWith(currentIngredients: updated));
  }

  // void updateIngredientGrams(int index, String gramsText) {
  //   final updated = [...state.currentIngredients];
  //   updated[index] = updated[index].copyWith(
  //     grams: num.tryParse(gramsText.trim()) ?? 0,
  //   );
  //   final updatedState = state.copyWith(currentIngredients: updated);
  //   emit(
  //     updatedState.copyWith(estimatedNutrition: _calculateNutrition(updated)),
  //   );
  // }

  void addIngredient() {
    emit(
      state.copyWith(
        currentIngredients: [
          ...state.currentIngredients,
          const IngredientModel(),
        ],
      ),
    );
  }

  // void removeIngredient(int index) {
  //   if (state.currentIngredients.length == 1) return;
  //   final updated = [...state.currentIngredients]..removeAt(index);
  //   emit(
  //     state.copyWith(
  //       currentIngredients: updated,
  //       estimatedNutrition: _calculateNutrition(updated),
  //     ),
  //   );
  // }

  Future<void> saveMeal() async {
    emit(state.copyWith(status: AddMealStatus.loading));
    final mealModel = MealModel(
      mealName: state.currentMealName,
      mealType: state.currentMealType ?? 'Unknown',
      imageUrl:
          state.meal?.imageUrl ??
          "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
      nutrition: state.estimatedNutrition,
      ingredients: state.currentIngredients,
    );
    final result = await addMealRepository.saveMeal(
      mealModel: mealModel,
      mealType: state.currentMealType ?? 'Unknown',
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: AddMealStatus.failure, errorMessage: failure),
      ),
      (_) => emit(state.copyWith(status: AddMealStatus.saveSuccess)),
    );
  }

  // NutritionModel _calculateNutrition(List<IngredientModel> ingredients) {
  //   if (state.meal != null && _matchesSearchedMeal(ingredients)) {
  //     return state.meal!.nutrition;
  //   }
  //   final totalGrams = ingredients.fold<double>(
  //     0,
  //     (sum, ing) => sum + ing.grams.toDouble(),
  //   );
  //   if (totalGrams == 0) return const NutritionModel();
  //   final protein = totalGrams * 0.15;
  //   final carbs = totalGrams * 0.45;
  //   final fats = totalGrams * 0.10;
  //   return NutritionModel(
  //     calories: (protein * 4) + (carbs * 4) + (fats * 9),
  //     protein: protein,
  //     carbs: carbs,
  //     fats: fats,
  //   );
  // }

  // bool _matchesSearchedMeal(List<IngredientModel> ingredients) {
  //   final searchMeal = state.meal!;
  //   if (searchMeal.ingredients.length != ingredients.length) return false;
  //   for (int i = 0; i < ingredients.length; i++) {
  //     if (ingredients[i].name.trim().toLowerCase() !=
  //         searchMeal.ingredients[i].name.toLowerCase())
  //       return false;
  //     if (ingredients[i].grams != searchMeal.ingredients[i].grams) return false;
  //   }
  //   return true;
  // }
}
