import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/add_meal/data/models/meal_model.dart';
import 'package:nutrilens/features/add_meal/presentation/widgets/nutrition_progress_bar.dart';

/// Displays the Estimated Nutrition card with calories and macro progress bars.
class NutritionCardWidget extends StatelessWidget {
  final MealModel? mealModel;

  const NutritionCardWidget({
    super.key,
    required this.mealModel,
  });

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
