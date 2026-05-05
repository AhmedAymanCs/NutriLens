import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';

class PasswordValidation extends StatelessWidget {
  const PasswordValidation({
    super.key,
    required this.hasUpperLetter,
    required this.hasLowerLetter,
    required this.hasANumber,
    required this.hasSpecialCharacter,
    required this.hasCharacterLength,
    this.isSignUpScreen = false,
    this.hasMatchedPassword,
  });

  final bool hasUpperLetter;
  final bool hasLowerLetter;
  final bool hasANumber;
  final bool hasSpecialCharacter;
  final bool hasCharacterLength;
  final bool isSignUpScreen;
  final bool? hasMatchedPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildRowPasswordValidation(text:  "At Least 1 Number",hasValidation:  hasANumber),
        BuildRowPasswordValidation(text:"At Least 8 Characters", hasValidation: hasCharacterLength),
        BuildRowPasswordValidation(
          text:"At Least 1 Lowercase Letter", hasValidation: hasLowerLetter,
        ),
        BuildRowPasswordValidation(
          text:"At Least 1 Special Character", hasValidation: hasSpecialCharacter,
        ),
        BuildRowPasswordValidation(
          text:"At Least 1 Uppercase Letter", hasValidation: hasUpperLetter,
        ),
        isSignUpScreen && hasMatchedPassword != null
            ? BuildRowPasswordValidation(
                text: "Matched Password", hasValidation: hasMatchedPassword!,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class BuildRowPasswordValidation extends StatelessWidget {
  const BuildRowPasswordValidation({
    super.key,
    required this.text,
    required this.hasValidation,
  });

  final String text;
  final bool hasValidation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        hasValidation
            ? Icon(Icons.check, size: 20.sp, color: ColorsManager.primary)
            : CircleAvatar(
                backgroundColor: ColorsManager.overlayBlack10,
                radius: 3.w,
              ),
        widthSpace(8.w),
        Text(
          text,
          style: AppTextStyle.font13GreyW400.copyWith(
            decoration: hasValidation ? TextDecoration.lineThrough : null,
            decorationColor: hasValidation ? ColorsManager.success : null,
            decorationThickness: hasValidation ? 2.w : null,
          ),
        ),
      ],
    );
  }
}
