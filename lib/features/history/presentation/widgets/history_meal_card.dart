import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/models/food_model.dart';
import 'package:nutrilens/core/utils/spacer.dart';

class HistoryMealCard extends StatelessWidget {
  final FoodModel meal;

  const HistoryMealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          const Column(
            children: [
              Expanded(
                child: VerticalDivider(
                  thickness: 2,
                  color: ColorsManager.gray200,
                ),
              ),
            ],
          ),
          widthSpace(16),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: ColorsManager.gray200),
              ),
              child: Row(
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(12.r),
                  //   child: ColorFiltered(
                  //     colorFilter: !meal.isEaten
                  //         ? const ColorFilter.matrix([
                  //             0.2126,
                  //             0.7152,
                  //             0.0722,
                  //             0,
                  //             0,
                  //             0.2126,
                  //             0.7152,
                  //             0.0722,
                  //             0,
                  //             0,
                  //             0.2126,
                  //             0.7152,
                  //             0.0722,
                  //             0,
                  //             0,
                  //             0,
                  //             0,
                  //             0,
                  //             1,
                  //             0,
                  //           ])
                  //         : const ColorFilter.mode(
                  //             Colors.transparent,
                  //             BlendMode.multiply,
                  //           ),
                  //     child: Image.network(
                  //       meal.imageUrl,
                  //       width: 60.w,
                  //       height: 60.w,
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  widthSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              meal.mealType,
                              style: AppTextStyle.font18BlackBold(context),
                            ),
                            // MealStatusWidget(isEaten: meal.isEaten),
                          ],
                        ),
                        Text(
                          "${meal.mealType} • ${meal.createdAt}",
                          style: AppTextStyle.font13GreyW400(context),
                        ),
                        heightSpace(4),
                        Text(
                          "${meal.nutrition.calories} ${StringManager.kcal}",
                          style: AppTextStyle.font16PrimaryBold.copyWith(
                            color: ColorsManager.gray500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
