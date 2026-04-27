import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:scroll_wheel_selector/scroll_wheel_selector.dart';

class SetAge extends StatelessWidget {
  const SetAge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(StringManager.ageTitle, style: AppTextStyle.font24BlackW700),
        heightSpace(16),
        Text(StringManager.ageSubTitle1),
        Text(StringManager.ageSubTitle2),
        Text(StringManager.ageSubTitle3),
        heightSpace(50),
        CircleAvatar(
          radius: 100.r,
          backgroundColor: ColorsManager.primaryLight,
          child: WheelPicker(
            height: 150.h,
            values: List.generate(99, (i) => i + 1),
            initialValue: 18,
            lineColor: ColorsManager.primary,
            selectedColor: ColorsManager.textHeading,
            unselectedColor: ColorsManager.textMuted,
            onSelected: (value) {
              debugPrint("Selected value: $value");
            },
          ),
        ),
        heightSpace(32),
        Text(StringManager.years, style: AppTextStyle.font24BlackW700),
      ],
    );
  }
}
