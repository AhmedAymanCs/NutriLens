import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/widgets/user_information.dart';

class SetGender extends StatelessWidget {
  const SetGender({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.watch<OnboardingCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringManager.genderTitle,
              style: AppTextStyle.font24BlackW700(context),
            ),
            heightSpace(16),
            const Text(StringManager.genderSubTitle),
            heightSpace(32),
            UserInformation(
              title: StringManager.genderFemale,
              onTap: () {
                cubit.selectGender(gender: Gender.female);
              },
              isSelected: state.selectedGender == Gender.female,
              icon: Icons.female_outlined,
            ),
            heightSpace(20),
            UserInformation(
              title: StringManager.genderMale,
              onTap: () {
                cubit.selectGender(gender: Gender.male);
              },
              isSelected: state.selectedGender == Gender.male,
              icon: Icons.male_outlined,
            ),
          ],
        );
      },
    );
  }
}
