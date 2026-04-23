import 'dart:math';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w800;
}

class FontSize {
  static double get s10 => min(10.0.sp, 12.0);
  static double get s12 => min(12.0.sp, 14.0);
  static double get s14 => min(14.0.sp, 16.0);
  static double get s16 => min(16.0.sp, 18.0);
  static double get s18 => min(18.0.sp, 20.0);
  static double get s20 => min(20.0.sp, 22.0);
  static double get s22 => min(22.0.sp, 26.0);
  static double get s24 => min(24.0.sp, 28.0);
  static double get s26 => min(26.0.sp, 30.0);
  static double get s28 => min(28.0.sp, 32.0);
  static double get s35 => min(35.0.sp, 40.0);
}
