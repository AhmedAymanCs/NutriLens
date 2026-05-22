import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';

void openHeightAndWeightPicker({
  required OnboardingCubit cubit,
  required TextEditingController heightController,
  required BuildContext context,
  required TextEditingController weightController,
  bool isHeight = false,
}) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return SizedBox(
        height: 200,
        child: CupertinoPicker(
          itemExtent: 40,
          onSelectedItemChanged: (index) {
            final value = isHeight ? index + 100 : index + 30;
            if (isHeight) {
              cubit.selectHeight(selectedHeight: value.toDouble());
              weightController.text = (value - 100).toString().trim();
              heightController.text = value.toString().trim();
            } else {
              cubit.selectWeight(selectedWeight: value.toDouble());
              weightController.text = value.toString().trim();
            }
          },
          children: List.generate(
            isHeight ? 121 : 171,
            (i) => Center(
              child: Text(isHeight ? '${i + 100} cm' : '${i + 30} kg'),
            ),
          ),
        ),
      );
    },
  );
}
