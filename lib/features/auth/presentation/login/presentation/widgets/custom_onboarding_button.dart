import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        minimumSize: Size(double.infinity, 50),
        backgroundColor: ColorsManager.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Continue",
            style: TextStyle(fontSize: 20, color: ColorsManager.backgroundWhite,
            ),
          ),
          SizedBox(width: 50),
          Icon(Icons.arrow_forward_ios, color: ColorsManager.backgroundWhite, size: 20.sp,)
        ],
      ),
    );
  }
}
