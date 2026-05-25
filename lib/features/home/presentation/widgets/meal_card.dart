import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/models/food_model.dart';
import 'package:nutrilens/core/utils/spacer.dart';

class MealCard extends StatelessWidget {
  final FoodModel mealModel;

  const MealCard({super.key, required this.mealModel});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Container(
          //   width: 80.w,
          //   height: 80.h,
          //   decoration: const BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(24),
          //       bottomLeft: Radius.circular(24),
          //     ),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 12),
          //     child: Image.network(
          //       mealModel.imageUrl,
          //       fit: BoxFit.cover,
          //       errorBuilder: (context, error, stackTrace) {
          //         return Image.asset(ImageManager.logo, fit: BoxFit.cover);
          //       },
          //     ),
          //   ),
          // ),
          heightSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mealModel.mealType, style: AppTextStyle.font16PrimaryBold),
                heightSpace(4),
                // Text(mealModel.foodName, style: AppTextStyle.font13GreyW400),
                heightSpace(4),
                // Text(
                //   mealModel.quantity.toString(),
                //   style: AppTextStyle.font13primaryColorW400,
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "${mealModel.nutrition.calories.toString()} ${StringManager.kcal}",
              style: AppTextStyle.font16PrimaryBold,
            ),
          ),
        ],
      ),
    );
  }
}
