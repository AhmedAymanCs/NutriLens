import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/core/widgets/custom_form_field.dart';

class HeightWeightInput extends StatelessWidget {
  final String label;
  final String unit;
  final TextEditingController controller;
  final VoidCallback onPickerTap;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmitted;

  const HeightWeightInput({
    super.key,
    required this.label,
    required this.unit,
    required this.controller,
    this.onChanged,
    required this.onPickerTap,
    this.validator,
    this.onSubmitted,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.font18BlackBold),

        heightSpace(6),

        Row(
          children: [
            Expanded(
              child: CustomFormField(
                hint: "Type your $label",
                validator: validator,
                onSubmitted: onSubmitted,
                onChanged: onChanged,
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}$')),
                ],
              ),
            ),
            widthSpace(8),
            IconButton(
              onPressed: onPickerTap,
              icon: const Icon(Icons.swap_vert),
            ),
          ],
        ),
      ],
    );
  }
}
