import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';

class CustomOnboardingButton extends StatelessWidget {
  const CustomOnboardingButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        shadowColor: ColorsManager.primary,
        elevation: 10,
        minimumSize: Size(double.infinity, 50.h),
        backgroundColor: ColorsManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Continue", style: AppTextStyle.font16WhiteW600),
          const Spacer(flex: 3),
          Icon(
            Icons.arrow_forward_ios,
            color: ColorsManager.backgroundWhite,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}
