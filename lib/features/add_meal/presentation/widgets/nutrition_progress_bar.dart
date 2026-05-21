import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';

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
