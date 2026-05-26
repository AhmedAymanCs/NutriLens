import 'package:equatable/equatable.dart';
import 'package:nutrilens/core/models/food_item_model.dart';
import 'package:nutrilens/core/models/food_model.dart';

enum AddMealStatus { initial, loading, success, saveSuccess, failure }

class AddMealState extends Equatable {
  final AddMealStatus status;
  final String errorMessage;
  final String? currentMealType;
  final List<String> mealTypes;
  final List<FoodItemModel> foodItems;
  final List<FoodItemModel> filteredFoodItems;
  final List<FoodItemModel> selectedFoodItems;
  final FoodItemModel? currentFoodItem;
  final FoodModel? selectedMeal;
  final bool isvalidIngredient;
  final NutritionModel nutrition;

  const AddMealState({
    this.status = AddMealStatus.initial,
    this.mealTypes = const ['Breakfast', 'Lunch', 'Dinner', 'Snack'],
    this.errorMessage = '',
    this.currentMealType = 'Breakfast',
    this.foodItems = const [],
    this.filteredFoodItems = const [],
    this.selectedFoodItems = const [],
    this.currentFoodItem,
    this.selectedMeal,
    this.isvalidIngredient = false,
    this.nutrition = const NutritionModel(
      calories: 0,
      protein: 0,
      carbs: 0,
      fats: 0,
    ),
  });

  AddMealState copyWith({
    AddMealStatus? status,
    String? errorMessage,
    String? currentMealType,
    List<FoodItemModel>? foodItems,
    List<FoodItemModel>? filteredFoodItems,
    List<FoodItemModel>? selectedFoodItems,
    FoodItemModel? currentFoodItem,
    FoodModel? selectedMeal,
    bool? isvalidIngredient,
    NutritionModel? nutrition,
  }) => AddMealState(
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    currentMealType: currentMealType ?? this.currentMealType,
    foodItems: foodItems ?? this.foodItems,
    filteredFoodItems: filteredFoodItems ?? this.filteredFoodItems,
    selectedFoodItems: selectedFoodItems ?? this.selectedFoodItems,
    currentFoodItem: currentFoodItem ?? this.currentFoodItem,
    selectedMeal: selectedMeal ?? this.selectedMeal,
    isvalidIngredient: isvalidIngredient ?? this.isvalidIngredient,
    nutrition: nutrition ?? this.nutrition,
  );

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    currentMealType,
    foodItems,
    filteredFoodItems,
    selectedFoodItems,
    currentFoodItem,
    selectedMeal,
    isvalidIngredient,
    nutrition,
  ];
}
