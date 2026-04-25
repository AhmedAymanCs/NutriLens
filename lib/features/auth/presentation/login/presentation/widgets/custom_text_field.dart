// import 'package:auth/core/style/colors/app_colors.dart';
// import 'package:auth/core/style/fonts/app_text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomTextField extends StatelessWidget {
//   const CustomTextField({
//     super.key,
//     this.labelText,
//     this.controller,
//     this.validator,
//     this.keyboardType,
//     this.isPassword = false,
//     this.suffixIcon,
//     this.prefixIcon,
//   });
//   final String? labelText;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   final TextInputType? keyboardType;
//   final bool isPassword;
//   final Widget? suffixIcon, prefixIcon;
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       validator: validator,
//       onTapOutside: (_) => FocusScope.of(context).unfocus(),
//       cursorColor: AppColors.kPrimaryColor,
//       cursorErrorColor: Colors.redAccent,
//       keyboardType: keyboardType ?? TextInputType.text,
//       obscureText: isPassword,
//       obscuringCharacter: "*",
//       decoration: InputDecoration(
//         isDense: true,
//         contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: const BorderSide(color: AppColors.kBorderColor),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: const BorderSide(color: AppColors.kBorderColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: const BorderSide(color: AppColors.kPrimaryColor),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: const BorderSide(color: AppColors.kErrorColor),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: const BorderSide(color: AppColors.kErrorColor),
//         ),
//         labelText: labelText ?? "Enter text here",
//         labelStyle: AppTextStyle.font15grey500,
//         suffixIcon: suffixIcon,
//         prefixIcon: prefixIcon,
//       ),
//     );
//   }
// }
