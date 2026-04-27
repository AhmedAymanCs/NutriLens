import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/widgets/user_information.dart';

class SetGoal extends StatelessWidget {
  const SetGoal({super.key, this.onTapGoalLoseWeight, this.onTapGoalMaintainWeight, this.onTapGoalGainWeight});
  final VoidCallback? onTapGoalLoseWeight, onTapGoalMaintainWeight, onTapGoalGainWeight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringManager.goalTitle, style: AppTextStyle.font24BlackW700),
          heightSpace(16),
          Text(StringManager.goalSubTitle),
          heightSpace(32),
          UserInformation(
            onTap: onTapGoalLoseWeight ?? () {},
            title: StringManager.goalLoseWeight,
            icon: Icons.trending_down_outlined,
          ),
          heightSpace(20),
          UserInformation(
            onTap: onTapGoalMaintainWeight ?? () {},
            title: StringManager.goalMaintainWeight,
            icon: Icons.monitor_weight_outlined,
          ),
          heightSpace(20),
          UserInformation(
            onTap: onTapGoalGainWeight ?? () {},
            title: StringManager.goalGainWeight,
            icon: Icons.trending_up_outlined,
          ),
          heightSpace(50),
        ],
      ),
    );
  }
}
