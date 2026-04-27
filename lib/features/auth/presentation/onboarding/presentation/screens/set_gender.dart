import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/widgets/user_information.dart';

class SetGender extends StatelessWidget {
  const SetGender({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringManager.genderTitle, style: AppTextStyle.font24BlackW700),
        heightSpace(16),
        Text(
          StringManager.genderSubTitle,
        ),
        heightSpace(32),
        UserInformation(
          onTap: onTap,
          title: StringManager.genderFemale, icon: Icons.female_outlined),
        heightSpace(20),
        UserInformation(
          onTap: onTap,
          title: StringManager.genderMale, icon: Icons.male_outlined),
      ],
    );
  }
}
