import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';

class MealStatusWidget extends StatelessWidget {
  const MealStatusWidget({super.key, required this.isEaten});

  final bool isEaten;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isEaten
            ? ColorsManager.primary.withValues(alpha: 0.1)
            : ColorsManager.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        isEaten ? StringManager.eaten : StringManager.missed,
        style: AppTextStyle.font11BlackW600.copyWith(
          color: isEaten ? ColorsManager.primary : ColorsManager.error,
        ),
      ),
    );
  }
}
