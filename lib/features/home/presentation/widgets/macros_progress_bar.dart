import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/features/home/presentation/widgets/macro_indicator.dart';

class MacrosProgressBar extends StatelessWidget {
  const MacrosProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MacroIndicator(
          title: StringManager.protein,
          current: 45,
          total: 120,
          color: ColorsManager.protein,
          icon: Icons.fitness_center,
        ),
        MacroIndicator(
          title: StringManager.carbs,
          current: 120,
          total: 250,
          color: ColorsManager.carbs,
          icon: Icons.bolt,
        ),
        MacroIndicator(
          title: StringManager.fat,
          current: 32,
          total: 65,
          color: ColorsManager.primary,
          icon: Icons.water_drop_outlined,
        ),
      ],
    );
  }
}
