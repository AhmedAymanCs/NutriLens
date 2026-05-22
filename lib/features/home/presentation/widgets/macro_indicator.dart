import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';

class MacroIndicator extends StatelessWidget {
  final String title;
  final num current;
  final num total;
  final Color color;
  final IconData icon;

  const MacroIndicator({
    super.key,
    required this.title,
    required this.current,
    required this.total,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.backgroundWhite,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: ColorsManager.overlayBlack10.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyle.font11BlackW600.copyWith(
                  color: ColorsManager.gray500,
                ),
              ),
              widthSpace(4),
              Icon(icon, size: 12, color: color),
            ],
          ),
          heightSpace(8),
          RichText(
            text: TextSpan(
              style: AppTextStyle.font11BlackW600,
              children: [
                TextSpan(
                  text: '$current',
                  style: AppTextStyle.font18BlackBold.copyWith(
                    color: ColorsManager.textBlack,
                  ),
                ),
                TextSpan(
                  text: ' / ${total}g',
                  style: AppTextStyle.font11BlackW600.copyWith(
                    color: ColorsManager.textMuted,
                  ),
                ),
              ],
            ),
          ),
          heightSpace(8),
          LinearProgressIndicator(
            value: 50, // (current / total).clamp(0, 1),
            backgroundColor: ColorsManager.gray200,
            color: color,
            minHeight: 4,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      ),
    );
  }
}
