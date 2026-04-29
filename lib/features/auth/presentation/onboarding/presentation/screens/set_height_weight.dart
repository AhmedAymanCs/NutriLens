import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/utils/spacer.dart';
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
  late OnboardingCubit cubit;

  @override
  void initState() {
    cubit = context.read<OnboardingCubit>();
    heightController = TextEditingController(
      text: cubit.state.selectedHeightValue!.isNotEmpty
          ? "${cubit.state.selectedHeightValue} cm"
          : cubit.state.selectedHeightValue,
    );
    weightController = TextEditingController(
      text: cubit.state.selectedWeightValue!.isNotEmpty
          ? "${cubit.state.selectedWeightValue} kg"
          : cubit.state.selectedWeightValue,
    );
    super.initState();
  }

  void openHeightPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 40,
            onSelectedItemChanged: (index) {
              final value = index + 100;
              cubit.selectHeight(selectedHeightValue: "$value");
              weightController.text = (value - 100).toString().trim();
              heightController.text = value.toString().trim();
            },
            children: List.generate(
              121,
              (i) => Center(child: Text('${i + 100} cm')),
            ),
          ),
        );
      },
    );
  }

  void openWeightPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 40,
            onSelectedItemChanged: (index) {
              final value = (index + 30).toString().trim();
              cubit.selectWeight(selectedWeightValue: value);
              weightController.text = value;
            },
            children: List.generate(
              171,
              (i) => Center(child: Text('${i + 30} kg')),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OnboardingState state = context.watch<OnboardingCubit>().state;
    return Column(
      children: [
        Text("Add Your Height & Weight", style: AppTextStyle.font24BlackW700),

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
          onChanged: (v) {
            final height = int.tryParse(v!);
            if (height != null && height >= 100 && height <= 220) {
              cubit.selectHeight(selectedHeightValue: "$height");
              weightController.text = (height - 100).toString();
            }
          },
          onPickerTap: () => openHeightPicker(context),
        ),

        if (state.selectedHeightValue!.isNotEmpty ||
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
                cubit.selectWeight(selectedWeightValue: "$weight");
              }
            },
            onPickerTap: () => openWeightPicker(context),
          ),
        ],
      ],
    );
  }
}
