import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/core/widgets/custom_button.dart';
import 'package:nutrilens/features/add_meal/logic/add_meal_cubit.dart';
import 'package:nutrilens/features/add_meal/logic/add_meal_state.dart';
import 'package:nutrilens/features/add_meal/presentation/shared_widgets.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key});

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  // Controllers
  final TextEditingController _ingredientNameController =
      TextEditingController();
  final TextEditingController _ingredientGramsController =
      TextEditingController();

  @override
  void dispose() {
    _ingredientNameController.dispose();
    _ingredientGramsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMealCubit, AddMealState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<AddMealCubit>();
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: const SizedBox.shrink(),
            title: Text('Add Meal', style: AppTextStyle.font22PrimaryBold),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Meal Type ──────────────────────────────────────────────
                  DropdownButtonFormField<String>(
                    initialValue: state.currentMealType,
                    items: _mealTypes
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                    onChanged: (value) => cubit.updateFoodType(value),
                    validator: (value) =>
                        value == null ? 'Select meal type' : null,
                    decoration: const InputDecoration(hintText: 'Meal Type'),
                  ),

                  heightSpace(28),

                  // ── Ingredients Section ────────────────────────────────────
                  Text('Ingredients', style: AppTextStyle.font18BlackBold),
                  heightSpace(16),

                  // Ingredient name field with search
                  IngredientSearchField(
                    nameController: _ingredientNameController,
                    gramsController: _ingredientGramsController,
                    searchResults: state.filteredFoodItems,
                    onSearch: cubit.searchFoodItems,
                    onSelect: (foodItem) {
                      _ingredientNameController.text = foodItem.name;
                      cubit.selectFoodItem(foodItem);
                    },
                  ),
                  heightSpace(12),
                  // Add button
                  Center(
                    child: SizedBox(
                      width: 200.w,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          cubit.submitIngredient(
                            name: _ingredientNameController.text.trim(),
                            grams: double.tryParse(
                              _ingredientGramsController.text.trim(),
                            )!,
                          );
                          _ingredientNameController.clear();
                          _ingredientGramsController.clear();
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add'),
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

                  heightSpace(16),

                  // Added ingredients list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.selectedFoodItems.length,
                    itemBuilder: (context, index) => IngredientRow(
                      ingredient: state.selectedFoodItems[index],
                      onRemove: () => cubit.removeIngredient(index),
                    ),
                  ),
                  if (state.selectedFoodItems.isNotEmpty) heightSpace(16),
                  heightSpace(16),
                  // ── Nutrition Card ─────────────────────────────────────────
                  NutritionCard(
                    calories: state.nutrition.calories,
                    protein: state.nutrition.protein,
                    carbs: state.nutrition.carbs,
                    fats: state.nutrition.fats,
                  ),
                  heightSpace(36),
                  // ── Save Button ────────────────────────────────────────────
                  CustomButton(text: 'Save Meal', onPressed: cubit.saveMeal),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
