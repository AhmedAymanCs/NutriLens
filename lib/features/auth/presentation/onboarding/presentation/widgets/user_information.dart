import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({
    super.key,
    required this.title,
    this.icon,
    this.width,
    this.height,
    required this.onTap,
  });
  final String title;
  final IconData? icon;
  final double? width, height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    OnboardingCubit cubit = context.watch<OnboardingCubit>();
    bool isSelected =
        cubit.state.selectedGenderValue == title ||
        cubit.state.selectedGoalValue == title;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 100.h,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color:
              
                isSelected
              ? ColorsManager.primary
              : ColorsManager.backgroundWhite,
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(color: ColorsManager.primary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style:
                  isSelected
                  ? AppTextStyle.font16WhiteWBold
                  : AppTextStyle.font16PrimaryBold,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor:
                    isSelected
                    ? ColorsManager.backgroundWhite
                    : ColorsManager.primaryLight,
                radius: 30.r,
                child: Icon(icon, color: ColorsManager.primary, size: 30.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
