import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';
import 'package:scroll_wheel_selector/scroll_wheel_selector.dart';

class SetAge extends StatelessWidget {
  const SetAge({super.key});

  @override
  Widget build(BuildContext context) {
    OnboardingCubit cubit = context.read<OnboardingCubit>();
    return Column(
      children: [
        Text(StringManager.ageTitle, style: AppTextStyle.font24BlackW700),
        heightSpace(16),
        const Text(StringManager.ageSubTitle1),
        const Text(StringManager.ageSubTitle2),
        const Text(StringManager.ageSubTitle3),
        heightSpace(50),
        CircleAvatar(
          radius: 120.r,
          backgroundColor: ColorsManager.primaryLight,
          child: WheelPicker(
            height: 150.h,
            values: List.generate(60, (i) => i + 1),
            initialValue: cubit.state.selectedAgeValue == 0
                ? 18
                : cubit.state.selectedAgeValue!,
            lineColor: ColorsManager.textHeading,
            selectedColor: ColorsManager.primary,
            unselectedColor: ColorsManager.textMuted,
            onSelected: (value) {
              cubit.selectAge(selectedAge: value);
            },
          ),
        ),
        heightSpace(32),
        Text(StringManager.years, style: AppTextStyle.font24BlackW700),
      ],
    );
  }
}
