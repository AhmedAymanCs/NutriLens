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
    required this.onTap,
    required this.isSelected,
  });
  final String title;
  final IconData? icon;
  final double? width, height;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: isSelected ? 50 : 0,
        shadowColor: ColorsManager.primaryLight,
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        color: isSelected
            ? ColorsManager.primary
            : ColorsManager.backgroundWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
          side: const BorderSide(color: ColorsManager.primary),
        ),
        child: Container(
          width: width ?? double.infinity,
          height: height ?? 100.h,
          padding: EdgeInsets.all(20.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: isSelected
                    ? AppTextStyle.font16WhiteWBold
                    : AppTextStyle.font16PrimaryBold,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  backgroundColor: isSelected
                      ? ColorsManager.backgroundWhite
                      : ColorsManager.primaryLight,
                  radius: 30.r,
                  child: Icon(icon, color: ColorsManager.primary, size: 30.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
