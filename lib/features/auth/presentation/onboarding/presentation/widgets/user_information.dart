import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({
    super.key,
    required this.title,
    this.icon,
    this.width,
    this.height,
    this.isSelected = false,
    required this.onTap,
  });
  final String title;
  final IconData? icon;
  final double? width, height;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 100.h,
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(color: ColorsManager.primary, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: AppTextStyle.font16PrimaryBold),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: ColorsManager.primaryLight,
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
