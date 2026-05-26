// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/core/widgets/custom_form_field.dart';
import 'package:nutrilens/core/models/food_item_model.dart';

class IngredientSearchField extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController gramsController;
  final List<FoodItemModel> searchResults;
  final void Function(String query) onSearch;
  final void Function(FoodItemModel item) onSelect;

  const IngredientSearchField({
    super.key,
    required this.nameController,
    required this.gramsController,
    required this.searchResults,
    required this.onSearch,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: CustomFormField(
                hint: 'Ingredient Name',
                controller: nameController,
                onChanged: (value) => onSearch(value ?? ''),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              flex: 2,
              child: CustomFormField(
                hint: 'Grams',
                controller: gramsController,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),

        // Search results dropdown
        if (searchResults.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: 4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: searchResults.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = searchResults[index];
                return ListTile(
                  dense: true,
                  title: Text(item.name),
                  onTap: () => onSelect(item),
                );
              },
            ),
          ),
      ],
    );
  }
}

class IngredientRow extends StatelessWidget {
  final FoodItemModel ingredient;
  final VoidCallback onRemove;

  const IngredientRow({
    super.key,
    required this.ingredient,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorsManager.primary),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(ingredient.name, style: AppTextStyle.font16PrimaryBold),
          ),
          Text(
            '${ingredient.servingSizeG.toStringAsFixed(0)}g',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey[800]),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, color: Colors.red, size: 20),
          ),
        ],
      ),
    );
  }
}

class NutritionCard extends StatelessWidget {
  final num calories;
  final num protein;
  final num carbs;
  final num fats;

  const NutritionCard({
    super.key,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nutrition Info', style: AppTextStyle.font18BlackBold(context)),
          heightSpace(12),
          _NutritionRow(label: 'Calories', value: calories, unit: 'kcal'),
          _NutritionRow(label: 'Protein', value: protein, unit: 'g'),
          _NutritionRow(label: 'Carbohydrates', value: carbs, unit: 'g'),
          _NutritionRow(label: 'Fats', value: fats, unit: 'g'),
        ],
      ),
    );
  }
}

class _NutritionRow extends StatelessWidget {
  final String label;
  final num value;
  final String unit;

  const _NutritionRow({
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          Text(
            '${value.toStringAsFixed(1)} $unit',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ColorsManager.primary,
            ),
          ),
        ],
      ),
    );
  }
}
