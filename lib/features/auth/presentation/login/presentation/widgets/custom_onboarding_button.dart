import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';

class CustomOnboardingButton extends StatelessWidget {
  const CustomOnboardingButton({super.key, this.onPressed, required this.text});
  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shadowColor: ColorsManager.primary,
        elevation: 10,
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: ColorsManager.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: AppTextStyle.font16WhiteW600.copyWith(fontSize: 20.sp),
          ),
          const Spacer(),
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
