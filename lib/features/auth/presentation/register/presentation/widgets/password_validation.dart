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
        buildRowPasswordValidation("At Least 1 Number", hasANumber),
        buildRowPasswordValidation("At Least 8 Characters", hasCharacterLength),
        buildRowPasswordValidation(
          "At Least 1 Lowercase Letter",
          hasLowerLetter,
        ),
        buildRowPasswordValidation(
          "At Least 1 Special Character",
          hasSpecialCharacter,
        ),
        buildRowPasswordValidation(
          "At Least 1 Uppercase Letter",
          hasUpperLetter,
        ),
        isSignUpScreen && hasMatchedPassword != null
            ? buildRowPasswordValidation(
                "Matched Password",
                hasMatchedPassword!,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

Row buildRowPasswordValidation(String text, bool hasValidation) {
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
