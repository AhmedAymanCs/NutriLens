import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/color_manager.dart';

class AppTextStyle {
  static TextStyle font16RedW600 = TextStyle(
    color: ColorsManager.error,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font13PrimaryW400 = TextStyle(
    color: ColorsManager.primary,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle font13primaryColorW400 = TextStyle(
    color: ColorsManager.primary,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle font22PrimaryBold = TextStyle(
    color: ColorsManager.primary,
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16PrimaryBold = TextStyle(
    color: ColorsManager.primary,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font32PrimaryBold = TextStyle(
    color: ColorsManager.primary,
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16WhiteW600 = TextStyle(
    color: ColorsManager.textLight,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font22WhiteWBold = TextStyle(
    color: ColorsManager.textLight,
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16WhiteWBold = TextStyle(
    color: ColorsManager.textLight,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font14WhiteW400 = TextStyle(
    color: ColorsManager.textLight,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle font24BlackW700(BuildContext context) => TextStyle(
    color: ColorsManager.adaptiveTextHeading(context),
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle font11BlackW600(BuildContext context) => TextStyle(
    color: ColorsManager.adaptiveTextHeading(context),
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle font16BlackBold(BuildContext context) => TextStyle(
    color: ColorsManager.adaptiveTextHeading(context),
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font18BlackBold(BuildContext context) => TextStyle(
    color: ColorsManager.adaptiveTextHeading(context),
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle font13GreyW400(BuildContext context) => TextStyle(
    color: ColorsManager.adaptiveTextSecondary(context),
    fontSize: 13.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle font15GreyW500(BuildContext context) => TextStyle(
    color: ColorsManager.adaptiveTextSecondary(context),
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
  );
}
