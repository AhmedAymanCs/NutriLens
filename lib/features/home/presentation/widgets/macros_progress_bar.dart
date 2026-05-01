import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/features/home/data/model/home_data_model.dart';
import 'package:nutrilens/features/home/presentation/widgets/macro_indicator.dart';

class MacrosProgressBar extends StatelessWidget {
  const MacrosProgressBar({super.key, required this.data});

  final HomeDataModel data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MacroIndicator(
          title: StringManager.protein,
          current:data.proteinConsumed,
          total:data.proteinGoal,
          color: ColorsManager.protein,
          icon: Icons.fitness_center,
        ),
        MacroIndicator(
          title: StringManager.carbs,
          current: data.carbsConsumed,
          total:data.carbsGoal,
          color: ColorsManager.carbs,
          icon: Icons.bolt,
        ),
        MacroIndicator(
          title: StringManager.fat,
          current: data.fatsConsumed,
          total: data.fatsGoal,
          color: ColorsManager.primary,
          icon: Icons.water_drop_outlined,
        ),
      ],
    );
  }
}
