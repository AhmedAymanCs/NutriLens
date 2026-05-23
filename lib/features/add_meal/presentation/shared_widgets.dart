import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/add_meal/data/models/food_item_model.dart';
import 'package:nutrilens/features/add_meal/data/models/meal_model.dart';

class IngredientAutoCompleteField extends StatelessWidget {
  final TextEditingController controller;
  final List<FoodItemModel> suggestions;
  final void Function(String query) onSearch;
  final void Function(FoodItemModel selected) onSelected;
  final bool Function(String value) isValid;

  const IngredientAutoCompleteField({
    super.key,
    required this.controller,
    required this.suggestions,
    required this.onSearch,
    required this.onSelected,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<FoodItemModel>(
      optionsBuilder: (textEditingValue) {
        onSearch(textEditingValue.text);
        return suggestions;
      },
      displayStringForOption: (item) => item.name,
      onSelected: (item) {
        controller.text = item.name;
        onSelected(item);
      },
      fieldViewBuilder: (context, textController, focusNode, onSubmitted) {
        textController.text = controller.text;
        return TextFormField(
          controller: textController,
          focusNode: focusNode,
          cursorColor: ColorsManager.primary,
          validator: (value) {
            if (value == null || value.trim().isEmpty) return 'Required';
            if (!isValid(value)) return 'Not Found';
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Ingredient',
            hintStyle: const TextStyle(color: ColorsManager.gray500),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: ColorsManager.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: ColorsManager.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: ColorsManager.error),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: ColorsManager.gray500),
            ),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12.r),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200.h),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 4.h),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final item = options.elementAt(index);
                  return ListTile(
                    title: Text(item.name, style: AppTextStyle.font15GreyW500),
                    subtitle: Text(
                      item.nameEn,
                      style: TextStyle(
                        color: ColorsManager.gray500,
                        fontSize: 12.sp,
                      ),
                    ),
                    onTap: () => onSelected(item),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Displays a single macro row: label, progress bar, and value.
class NutritionProgressBar extends StatelessWidget {
  final String label;
  final double value;
  final String unit;
  final double progress;
  final Color progressColor;

  const NutritionProgressBar({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.progress,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyle.font18BlackBold),
            Text('${value.toStringAsFixed(0)}$unit'),
          ],
        ),
        heightSpace(6),
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: 10.h,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: ColorsManager.backgroundWhite,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: progressColor),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                  width: progress,
                  decoration: BoxDecoration(
                    color: progressColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

/// Displays the Estimated Nutrition card with calories and macro progress bars.
class NutritionCardWidget extends StatelessWidget {
  final MealModel? mealModel;

  const NutritionCardWidget({super.key, required this.mealModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: ColorsManager.background,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          const BoxShadow(
            color: ColorsManager.gray500,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ESTIMATED NUTRITION', style: AppTextStyle.font16PrimaryBold),
          heightSpace(12),
          Text(
            mealModel?.nutrition.calories.toStringAsFixed(0) ?? "0",
            style: AppTextStyle.font22PrimaryBold,
          ),
          Text('Total Calories', style: AppTextStyle.font15GreyW500),
          const Divider(),
          heightSpace(20),
          NutritionProgressBar(
            label: 'Protein',
            value: mealModel?.nutrition.protein.toDouble() ?? 0,
            unit: 'g',
            progress: mealModel?.nutrition.protein.toDouble() ?? 0,
            progressColor: ColorsManager.primary,
          ),
          heightSpace(14),
          NutritionProgressBar(
            label: 'Carbs',
            value: mealModel?.nutrition.carbs.toDouble() ?? 0,
            unit: 'g',
            progress: mealModel?.nutrition.carbs.toDouble() ?? 0,
            progressColor: ColorsManager.error,
          ),
          heightSpace(14),
          NutritionProgressBar(
            label: 'Fats',
            value: mealModel?.nutrition.fats.toDouble() ?? 0,
            unit: 'g',
            progress: mealModel?.nutrition.fats.toDouble() ?? 0,
            progressColor: ColorsManager.warning,
          ),
        ],
      ),
    );
  }
}
