import 'package:equatable/equatable.dart';
import 'package:nutrilens/features/add_meal/data/models/food_item_model.dart';
import 'package:nutrilens/features/add_meal/data/models/meal_model.dart';

enum AddMealStatus { initial, loading, getSuccess, saveSuccess, failure }

class AddMealState extends Equatable {
  final AddMealStatus status;
  final List<MealModel> meals;
  final MealModel? meal;
  final String errorMessage;
  final NutritionModel estimatedNutrition;
  final List<IngredientModel> currentIngredients;
  final String currentMealName;
  final String? currentMealType;
  final List<FoodItemModel> foodItems;
  final List<FoodItemModel> filteredFoodItems;

  const AddMealState({
    this.status = AddMealStatus.initial,
    this.meals = const [],
    this.meal,
    this.errorMessage = '',
    this.estimatedNutrition = const NutritionModel(),
    this.currentIngredients = const [IngredientModel()],
    this.currentMealName = '',
    this.currentMealType,
    this.foodItems = const [],
    this.filteredFoodItems = const [],
  });

  AddMealState copyWith({
    AddMealStatus? status,
    List<MealModel>? meals,
    MealModel? meal,
    String? errorMessage,
    NutritionModel? estimatedNutrition,
    List<IngredientModel>? currentIngredients,
    String? currentMealName,
    String? currentMealType,
    List<FoodItemModel>? foodItems,
    List<FoodItemModel>? filteredFoodItems,
  }) => AddMealState(
    status: status ?? this.status,
    meals: meals ?? this.meals,
    meal: meal ?? this.meal,
    errorMessage: errorMessage ?? this.errorMessage,
    estimatedNutrition: estimatedNutrition ?? this.estimatedNutrition,
    currentIngredients: currentIngredients ?? this.currentIngredients,
    currentMealName: currentMealName ?? this.currentMealName,
    currentMealType: currentMealType ?? this.currentMealType,
    foodItems: foodItems ?? this.foodItems,
    filteredFoodItems: filteredFoodItems ?? this.filteredFoodItems,
  );

  @override
  List<Object?> get props => [
    status,
    meals,
    meal,
    errorMessage,
    estimatedNutrition,
    currentIngredients,
    currentMealName,
    currentMealType,
    foodItems,
    filteredFoodItems,
  ];
}
