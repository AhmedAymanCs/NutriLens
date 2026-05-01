import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/home/data/model/meal_model.dart';

class MealCard extends StatelessWidget {
  final MealModel mealModel;

  const MealCard({
    super.key,
    required this.mealModel
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: ColorsManager.backgroundWhite,
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
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            child: Image.asset(mealModel.imageUrl),
          ),
          heightSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mealModel.foodName,
                  style: AppTextStyle.font16PrimaryBold.copyWith(color: ColorsManager.textBlack),
                ),
                heightSpace(4),
                Text(
                  mealModel.quantity.toString(),
                  style: AppTextStyle.font13primaryColorW400,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              mealModel.calories.toString(),
              style: AppTextStyle.font16PrimaryBold,
            ),
          ),
        ],
      ),
    );
  }
}