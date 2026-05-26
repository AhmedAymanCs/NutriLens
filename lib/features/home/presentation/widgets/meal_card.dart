import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/functions/helpers.dart';
import 'package:nutrilens/core/models/food_item_model.dart';
import 'package:nutrilens/core/models/food_model.dart';
import 'package:nutrilens/core/utils/spacer.dart';

class MealCard extends StatelessWidget {
  final FoodModel mealModel;

  const MealCard({super.key, required this.mealModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (_) => _MealIngredientsDialog(mealModel: mealModel),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.overlayBlack10.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            heightSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mealModel.mealType,
                    style: AppTextStyle.font16PrimaryBold,
                  ),
                  heightSpace(4),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                "${mealModel.nutrition.calories} ${StringManager.kcal}",
                style: AppTextStyle.font16PrimaryBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MealIngredientsDialog extends StatelessWidget {
  final FoodModel mealModel;

  const _MealIngredientsDialog({required this.mealModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DialogHeader(mealType: mealModel.mealType),
            heightSpace(8),
            Divider(color: ColorsManager.primary.withValues(alpha: 0.2)),
            heightSpace(8),
            _NutritionSummary(nutrition: mealModel.nutrition),
            heightSpace(12),
            Text("المكونات", style: AppTextStyle.font16PrimaryBold),
            heightSpace(8),
            _IngredientsList(ingredients: mealModel.ingredients),
          ],
        ),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  final String mealType;

  const _DialogHeader({required this.mealType});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(mealType, style: AppTextStyle.font16PrimaryBold),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close, color: ColorsManager.primary),
        ),
      ],
    );
  }
}

class _NutritionSummary extends StatelessWidget {
  final NutritionModel nutrition;

  const _NutritionSummary({required this.nutrition});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorsManager.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NutrientChip(
            label: "Calories",
            value: format(nutrition.calories),
            unit: "kcal",
          ),
          _NutrientChip(
            label: "Protein",
            value: format(nutrition.protein),
            unit: "g",
          ),
          _NutrientChip(
            label: "Carbs",
            value: format(nutrition.carbs),
            unit: "g",
          ),
          _NutrientChip(
            label: "Fats",
            value: format(nutrition.fats),
            unit: "g",
          ),
        ],
      ),
    );
  }
}

class _NutrientChip extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const _NutrientChip({
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$value ",
                    style: AppTextStyle.font16PrimaryBold,
                  ),
                  TextSpan(
                    text: unit,
                    style: AppTextStyle.font16PrimaryBold.copyWith(
                      color: ColorsManager.primary.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          heightSpace(4),
          Text(
            label,
            style: AppTextStyle.font16PrimaryBold.copyWith(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: ColorsManager.primary.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientsList extends StatelessWidget {
  final List<FoodItemModel> ingredients;

  const _IngredientsList({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300.h),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: ingredients.length,
        separatorBuilder: (_, _) =>
            Divider(color: ColorsManager.primary.withValues(alpha: 0.1)),
        itemBuilder: (_, index) => _IngredientRow(item: ingredients[index]),
      ),
    );
  }
}

class _IngredientRow extends StatelessWidget {
  final FoodItemModel item;

  const _IngredientRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTextStyle.font16PrimaryBold.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                heightSpace(2),
                Text(
                  item.nameEn,
                  style: AppTextStyle.font16PrimaryBold.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsManager.primary.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${format(item.calories)} kcal",
                style: AppTextStyle.font16PrimaryBold.copyWith(fontSize: 13.sp),
              ),
              heightSpace(2),
              Text(
                "${format(item.servingSizeG)}g",
                style: AppTextStyle.font16PrimaryBold.copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.primary.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
