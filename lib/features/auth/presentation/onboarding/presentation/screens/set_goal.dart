import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/widgets/user_information.dart';

class SetGoal extends StatelessWidget {
  const SetGoal({super.key});

  @override
  Widget build(BuildContext context) {
        OnboardingCubit cubit = context.read<OnboardingCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringManager.goalTitle, style: AppTextStyle.font24BlackW700),
          heightSpace(16),
          const Text(StringManager.goalSubTitle),
          heightSpace(32),
          UserInformation(
            onTap: () {
              cubit.selectGoal(
                goal: Goal.loseWeight,
                value: StringManager.goalLoseWeight,
              );
            },
            title: StringManager.goalLoseWeight,
            icon: Icons.trending_down_outlined,
          ),
          heightSpace(20),
          UserInformation(
            onTap: () {
              cubit.selectGoal(
                goal: Goal.maintainWeight,
                value: StringManager.goalMaintainWeight,
              );
            },
            title: StringManager.goalMaintainWeight,
            icon: Icons.monitor_weight_outlined,
          ),
          heightSpace(20),
          UserInformation(
            onTap:  () {
              cubit.selectGoal(
                goal: Goal.gainWeight,
                value: StringManager.goalGainWeight,
              );
            },
            title: StringManager.goalGainWeight,
            icon: Icons.trending_up_outlined,
          ),
          heightSpace(50),
        ],
      ),
    );
  }
}
