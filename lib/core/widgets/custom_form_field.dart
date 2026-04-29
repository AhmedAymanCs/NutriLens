import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/font_manager.dart';

class CustomFormField extends StatelessWidget {
  final String? title;
  final String hint;
  final IconData? preIcon;
  final Color? preIconColor;
  final VoidCallback? onPressed;
  final TextInputType? keyboardType;
  final bool obscure;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;

  const CustomFormField({
    super.key,
    this.title,
    required this.hint,
    this.preIcon,
    this.onPressed,
    this.keyboardType,
    this.obscure = false,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.preIconColor, this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: TextStyle(
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.medium,
            ),
          ),
          SizedBox(height: 5.h),
        ],
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          onSaved: onSubmitted,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          controller: controller,
          validator: validator,
          obscureText: obscure,
          cursorColor: ColorsManager.primary,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: preIcon != null
                ? Icon(preIcon, color: preIconColor ?? ColorsManager.gray500)
                : null,
            suffixIcon: onPressed != null
                ? IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: ColorsManager.gray500,
                    ),
                  )
                : null,
            hintText: hint,
            hintStyle: TextStyle(
              color: ColorsManager.gray500,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: ColorsManager.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: ColorsManager.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: ColorsManager.error),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: ColorsManager.gray500),
            ),
          ),
        ),
      ],
    );
  }
}
