import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/auth/data/func/auth_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/logic/cubit.dart';
import 'package:nutrilens/features/auth/presentation/onboarding/presentation/widgets/height_weight_input.dart';

class SetHeightWeight extends StatefulWidget {
  const SetHeightWeight({super.key});

  @override
  State<SetHeightWeight> createState() => _SetHeightWeightState();
}

class _SetHeightWeightState extends State<SetHeightWeight> {
  late TextEditingController heightController;
  late TextEditingController weightController;

  @override
  void initState() {
    final cubit = context.read<OnboardingCubit>();
    heightController = TextEditingController(
      text: cubit.state.selectedHeight! != 0.0
          ? "${cubit.state.selectedHeight} cm"
          : "",
    );
    weightController = TextEditingController(
      text: cubit.state.selectedWeight! != 0.0
          ? "${cubit.state.selectedWeight} kg"
          : "",
    );
    super.initState();
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        return Column(
          children: [
            Text(
              "Add Your Height & Weight",
              style: AppTextStyle.font24BlackW700(context),
            ),
            heightSpace(40),
            HeightWeightInput(
              label: "Height",
              unit: "cm",
              controller: heightController,
              validator: (value) {
                final height = int.tryParse(value!);
                if (height == null || height < 100 || height > 220) {
                  return "Height must be 100 - 220 cm";
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                final height = int.tryParse(value!);
                if (height != null && height >= 100 && height <= 220) {
                  cubit.selectHeight(selectedHeight: height.toDouble());
                  weightController.text = (height - 100).toString();
                }
              },
              onPickerTap: () => openHeightAndWeightPicker(
                context: context,
                cubit: cubit,
                heightController: heightController,
                weightController: weightController,
                isHeight: true,
              ),
            ),
            if (state.selectedHeight != 0.0 &&
                heightController.text.isNotEmpty) ...[
              heightSpace(16),
              HeightWeightInput(
                label: "Weight",
                unit: "kg",
                controller: weightController,
                validator: (value) {
                  final weight = int.tryParse(value!);
                  if (weight == null || weight < 30 || weight > 200) {
                    return "Weight must be 30 - 200 kg";
                  } else {
                    return null;
                  }
                },
                onChanged: (v) {
                  final weight = int.tryParse(v!);
                  if (weight != null && weight >= 30 && weight <= 200) {
                    cubit.selectWeight(
                      selectedWeight: state.selectedWeight == 0.0
                          ? double.parse(weightController.text.trim())
                          : weight.toDouble(),
                    );
                  }
                },
                onPickerTap: () => openHeightAndWeightPicker(
                  context: context,
                  cubit: cubit,
                  heightController: heightController,
                  weightController: weightController,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
