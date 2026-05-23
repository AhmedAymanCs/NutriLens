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
import 'package:nutrilens/features/add_meal/logic/add_meal_cubit.dart';
import 'package:nutrilens/features/add_meal/logic/add_meal_state.dart';
import 'package:nutrilens/features/add_meal/presentation/screens/shared_widgets.dart';
import 'package:nutrilens/features/add_meal/presentation/widgets/nutrition_card_widget.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key});

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  final TextEditingController _mealNameController = TextEditingController();
  final List<TextEditingController> _nameControllers = [];
  final List<TextEditingController> _gramControllers = [];

  @override
  void initState() {
    super.initState();
    _nameControllers.add(TextEditingController());
    _gramControllers.add(TextEditingController());
    context.read<AddMealCubit>().getMealElements();
  }

  @override
  void dispose() {
    _mealNameController.dispose();
    for (final c in _nameControllers) c.dispose();
    for (final c in _gramControllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const SizedBox.shrink(),
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
          } else if (state.status == AddMealStatus.getSuccess) {
            // Sync controllers with data from cubit
            _mealNameController.text = state.currentMealName;

            for (final c in _nameControllers) c.dispose();
            for (final c in _gramControllers) c.dispose();
            _nameControllers.clear();
            _gramControllers.clear();

            for (final ing in state.currentIngredients) {
              _nameControllers.add(TextEditingController(text: ing.name));
              _gramControllers.add(
                TextEditingController(text: ing.grams.toString()),
              );
            }

            customSnackBar(
              context: context,
              message: 'Loaded recipe details for: ${state.currentMealName}',
              isErrorMessage: false,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AddMealCubit>();

          // Keep controllers list in sync with state ingredients count
          while (_nameControllers.length < state.currentIngredients.length) {
            _nameControllers.add(TextEditingController());
            _gramControllers.add(TextEditingController());
          }
          while (_nameControllers.length > state.currentIngredients.length) {
            _nameControllers.removeLast().dispose();
            _gramControllers.removeLast().dispose();
          }

          final currentMealModel = MealModel(
            mealName: state.currentMealName,
            mealType: state.currentMealType ?? 'Unknown',
            imageUrl:
                state.meal?.imageUrl ??
                "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
            nutrition: state.estimatedNutrition,
            ingredients: state.currentIngredients,
          );

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meal image
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

                  // Meal name
                  CustomFormField(
                    hint: 'Meal Name',
                    controller: _mealNameController,
                    onChanged: (value) => cubit.updateMealName(value ?? ''),
                    suffixIcon: GestureDetector(
                      onTap: () => cubit.searchInMeals(
                        mealName: _mealNameController.text.trim(),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: ColorsManager.primary,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter meal name';
                      }
                      return null;
                    },
                  ),

                  heightSpace(18),

                  // Meal type
                  DropdownButtonFormField<String>(
                    initialValue: state.currentMealType,
                    items: _mealTypes
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                    onChanged: cubit.updateMealType,
                    validator: (value) =>
                        value == null ? 'Select meal type' : null,
                  ),

                  heightSpace(28),

                  Text('Ingredients', style: AppTextStyle.font18BlackBold),
                  heightSpace(16),

                  // Ingredients list
                  ...List.generate(
                    state.currentIngredients.length,
                    (index) => IngredientAutoCompleteField(
                      foodItems: state.foodItems,
                      controller: _nameControllers[index],
                      onSelected: (item) {
                        cubit.updateIngredientName(index, item.name);
                      },
                    ),
                  ),
                  heightSpace(12),

                  // Add more
                  Center(
                    child: SizedBox(
                      width: 200.w,
                      child: OutlinedButton.icon(
                        onPressed: cubit.addIngredient,
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
                  NutritionCardWidget(mealModel: currentMealModel),
                  heightSpace(36),
                  CustomButton(
                    text: 'Save Meal',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.saveMeal();
                      }
                    },
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
