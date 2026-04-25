import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Spacer(),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "Forgot Password?",
            // style: AppTextStyle.font13primaryColor400.copyWith(
            //   decoration: TextDecoration.underline,
            //   decorationThickness: 1.5,
            //   decorationColor: ColorsManager.primary,
            // ),
          ),
        ),
      ],
    );
  }
}
