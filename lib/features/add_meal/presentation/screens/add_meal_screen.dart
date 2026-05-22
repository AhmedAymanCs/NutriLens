import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/custom_snack_bar.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/core/widgets/custom_button.dart';
import 'package:nutrilens/core/widgets/custom_form_field.dart';
import 'package:nutrilens/features/add_meal/data/models/meal_model.dart';
import 'package:nutrilens/features/add_meal/presentation/logic/add_meal_cubit.dart';
import 'package:nutrilens/features/add_meal/presentation/logic/add_meal_state.dart';
import 'package:nutrilens/features/add_meal/presentation/widgets/nutrition_card_widget.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key});

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController mealNameController = TextEditingController();
  String? selectedMealType;
  final List<String> mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
  final List<IngredientControllers> ingredients = [];

  @override
  void initState() {
    super.initState();
    // Start with one ingredient controller and add the listener to it
    final firstIngredient = IngredientControllers();
    firstIngredient.gramController.addListener(_onGramChanged);
    ingredients.add(firstIngredient);

    // Fetch meals in the background for local search
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddMealCubit>().getMealElements();
    });
  }

  void _onGramChanged() {
    setState(() {});
  }

  void addIngredient() {
    final controller = IngredientControllers();
    controller.gramController.addListener(_onGramChanged);
    setState(() {
      ingredients.add(controller);
    });
  }

  void removeIngredient(int index) {
    if (ingredients.length == 1) return;

    setState(() {
      ingredients[index].gramController.removeListener(_onGramChanged);
      ingredients[index].dispose();
      ingredients.removeAt(index);
    });
  }

  NutritionModel _calculateEstimatedNutrition(AddMealState state) {
    // If a meal was found via search and ingredients are unmodified, return its original nutrition
    if (state.meal != null && _isIngredientsUnchanged(state.meal!)) {
      return state.meal!.nutrition;
    }

    double totalGrams = 0;
    for (var ing in ingredients) {
      totalGrams += double.tryParse(ing.gramController.text) ?? 0;
    }
    if (totalGrams == 0) return const NutritionModel();

    // Smooth estimation formula based on general ingredient breakdown (15% protein, 45% carbs, 10% fats)
    final protein = totalGrams * 0.15;
    final carbs = totalGrams * 0.45;
    final fats = totalGrams * 0.10;
    final calories = (protein * 4) + (carbs * 4) + (fats * 9);

    return NutritionModel(
      calories: calories,
      protein: protein,
      carbs: carbs,
      fats: fats,
    );
  }

  bool _isIngredientsUnchanged(MealModel searchMeal) {
    if (searchMeal.ingredients.length != ingredients.length) return false;
    for (int i = 0; i < ingredients.length; i++) {
      if (ingredients[i].nameController.text.trim().toLowerCase() !=
          searchMeal.ingredients[i].name.toLowerCase()) {
        return false;
      }
      if (double.tryParse(ingredients[i].gramController.text.trim()) !=
          searchMeal.ingredients[i].grams) {
        return false;
      }
    }
    return true;
  }

  void saveMeal() {
    if (_formKey.currentState!.validate()) {
      final state = context.read<AddMealCubit>().state;
      final mealModel = MealModel(
        mealName: mealNameController.text.trim(),
        mealType: selectedMealType ?? 'Unknown',
        imageUrl:
            state.meal?.imageUrl ??
            "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
        nutrition: _calculateEstimatedNutrition(state),
        ingredients: ingredients.map((e) {
          return IngredientModel(
            name: e.nameController.text.trim(),
            grams: num.tryParse(e.gramController.text.trim()) ?? 0,
          );
        }).toList(),
      );

      context.read<AddMealCubit>().saveMeal(
        mealModel: mealModel,
        mealType: selectedMealType ?? 'Unknown',
      );
    }
  }

  @override
  void dispose() {
    mealNameController.dispose();
    for (var ingredient in ingredients) {
      ingredient.gramController.removeListener(_onGramChanged);
      ingredient.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading:const SizedBox.shrink(),
        title: Text('Add Meal', style: AppTextStyle.font22PrimaryBold),
        centerTitle: true,
      ),
      body: BlocConsumer<AddMealCubit, AddMealState>(
        listener: (context, state) {
          if (state.status == AddMealStatus.saveSuccess) {
            customSnackBar(
              context: context,
              message: 'Meal saved successfully!',
              isErrorMessage: false,
            );
            Navigator.of(context).pop();
          } else if (state.status == AddMealStatus.failure) {
            customSnackBar(context: context, message: state.errorMessage);
          } else if (state.status == AddMealStatus.getSuccess &&
              state.meal != null) {
            mealNameController.text = state.meal!.mealName;
            selectedMealType = state.meal!.mealType;

            for (var ing in ingredients) {
              ing.gramController.removeListener(_onGramChanged);
              ing.dispose();
            }
            ingredients.clear();

            if (state.meal!.ingredients.isEmpty) {
              final controller = IngredientControllers();
              controller.gramController.addListener(_onGramChanged);
              ingredients.add(controller);
            } else {
              for (var ing in state.meal!.ingredients) {
                final controller = IngredientControllers();
                controller.nameController.text = ing.name;
                controller.gramController.text = ing.grams.toString();
                controller.gramController.addListener(_onGramChanged);
                ingredients.add(controller);
              }
            }
            setState(() {});
            customSnackBar(
              context: context,
              message: 'Loaded recipe details for: ${state.meal!.mealName}',
              isErrorMessage: false,
            );
          }
        },
        builder: (context, state) {
          final estimatedNutrition = _calculateEstimatedNutrition(state);
          final currentMealModel = MealModel(
            mealName: mealNameController.text.trim(),
            mealType: selectedMealType ?? 'Unknown',
            imageUrl:
                state.meal?.imageUrl ??
                "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
            nutrition: estimatedNutrition,
            ingredients: ingredients.map((e) {
              return IngredientModel(
                name: e.nameController.text.trim(),
                grams: num.tryParse(e.gramController.text.trim()) ?? 0,
              );
            }).toList(),
          );

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Estimated image or placeholder
                  if (state.meal != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        width: double.infinity,
                        height: 200.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: ColorsManager.primary),
                          image: DecorationImage(
                            image: NetworkImage(state.meal!.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    heightSpace(15),
                  ],

                  /// Meal Name with Search Trigger
                  CustomFormField(
                    hint: 'Meal Name',
                    controller: mealNameController,
                    suffixIcon: const Icon(
                      Icons.search,
                      color: ColorsManager.primary,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter meal name';
                      }
                      return null;
                    },
                  ),

                  heightSpace(18),

                  /// Meal Type Dropdown
                  DropdownButtonFormField<String>(
                    initialValue: selectedMealType,
                    items: mealTypes.map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMealType = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Select meal type';
                      }
                      return null;
                    },
                  ),

                  heightSpace(28),
                  Text('Ingredients', style: AppTextStyle.font18BlackBold),

                  heightSpace(16),

                  ...List.generate(
                    ingredients.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(bottom: 14.h),
                      child: Row(
                        children: [
                          /// Ingredient Name
                          Expanded(
                            child: CustomFormField(
                              hint: 'Ingredient',
                              controller: ingredients[index].nameController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            ),
                          ),

                          widthSpace(12),

                          /// Grams
                          Expanded(
                            child: CustomFormField(
                              controller: ingredients[index].gramController,
                              keyboardType: TextInputType.number,
                              hint: 'Grams',
                              suffixIcon: Text(
                                'g',
                                style: AppTextStyle.font15GreyW500,
                              ),

                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                if (double.tryParse(value.trim()) == null) {
                                  return 'Type A Number';
                                }
                                return null;
                              },
                            ),
                          ),

                          widthSpace(5),

                          IconButton(
                            onPressed: () => removeIngredient(index),
                            icon: const Icon(
                              Icons.delete_outline,
                              color: ColorsManager.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  heightSpace(12),

                  /// Add More Button
                  Center(
                    child: SizedBox(
                      width: 200.w,
                      child: OutlinedButton.icon(
                        onPressed: addIngredient,
                        icon: const Icon(Icons.add),
                        label: const Text('Add More'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: ColorsManager.primary,
                          side: const BorderSide(color: ColorsManager.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  ),

                  heightSpace(24),

                  /// Estimated Nutrition Card
                  NutritionCardWidget(mealModel: currentMealModel),

                  heightSpace(36),

                  /// Save Meal Button
                  CustomButton(
                    text: 'Save Meal',
                    onPressed: state.status == AddMealStatus.loading
                        ? null
                        : saveMeal,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class IngredientControllers {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gramController = TextEditingController();

  void dispose() {
    nameController.dispose();
    gramController.dispose();
  }
}
