import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/home/presentation/widgets/status_column.dart';

class CalorieSummaryRing extends StatelessWidget {
  final num remaining;
  final num consumed;
  final num goal;

  const CalorieSummaryRing({
    super.key,
    required this.remaining,
    required this.consumed,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(
          height: 150.h,
          width: 150.w,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: consumed / goal,
                strokeWidth: 15,
                backgroundColor: ColorsManager.gray200,
                color: ColorsManager.primary, 
                strokeCap: StrokeCap.round,
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      StringManager.remaining,
                      style: AppTextStyle.font11BlackW600,
                    ),
                    Text(
                      '$remaining',
                      style: AppTextStyle.font24BlackW700.copyWith(color: ColorsManager.textBlack),
                    ),
                    Text(
                      StringManager.kcal,
                      style: AppTextStyle.font11BlackW600.copyWith(color: ColorsManager.gray500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        heightSpace(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StatusColumn(value: '$consumed', label: 'Consumed'),
            widthSpace(30),
            Container(width: 1, height: 30.h, color: ColorsManager.gray200),
            widthSpace(30),
            StatusColumn(value: '$goal', label: 'Goal'),
          ],
        ),
      ],
    );
  }

  
}