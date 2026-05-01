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
    OnboardingCubit cubit = context.watch<OnboardingCubit>();
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
              cubit.selectGoal(goal: Goal.loseWeight);
            },
            isSelected: cubit.state.selectedGoal == Goal.loseWeight,
            title: StringManager.goalLoseWeight,
            icon: Icons.trending_down_outlined,
          ),
          heightSpace(20),
          UserInformation(
            onTap: () {
              cubit.selectGoal(goal: Goal.maintainWeight);
            },
            isSelected: cubit.state.selectedGoal == Goal.maintainWeight,
            title: StringManager.goalMaintainWeight,
            icon: Icons.monitor_weight_outlined,
          ),
          heightSpace(20),
          UserInformation(
            onTap: () {
              cubit.selectGoal(goal: Goal.gainWeight);
            },
            isSelected: cubit.state.selectedGoal == Goal.gainWeight,
            title: StringManager.goalGainWeight,
            icon: Icons.trending_up_outlined,
          ),
          heightSpace(50),
        ],
      ),
    );
  }
}
