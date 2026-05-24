import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';

class DailyIntakeCard extends StatelessWidget {
  final num consumed;
  final num goal;

  const DailyIntakeCard({super.key, required this.consumed, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        // color: ColorsManager.backgroundWhite,
        borderRadius: BorderRadius.circular(24.r),
      
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringManager.dailyIntake, style: AppTextStyle.font15GreyW500),
          heightSpace(8),
          Row(
            children: [
              Text("$consumed", style: AppTextStyle.font24BlackW700.copyWith(color: ColorsManager.textBlack)),
              Text(" /$goal ${StringManager.kcal}", style: AppTextStyle.font15GreyW500),
              const Spacer(),
              CircleAvatar(
                backgroundColor: ColorsManager.primary.withValues(alpha: 0.2),
                child: Icon(Icons.local_fire_department, color: ColorsManager.primary),
              )
            ],
          ),
          heightSpace(12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: consumed / goal,
              minHeight: 10.h,
              backgroundColor: ColorsManager.gray200,
              valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.primary),
            ),
          ),
        ],
      ),
    );
  }
}