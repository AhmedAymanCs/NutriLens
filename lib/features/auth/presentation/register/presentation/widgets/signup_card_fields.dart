import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/have_an_account.dart';
import 'package:nutrilens/features/auth/presentation/register/presentation/widgets/sign_up_validation.dart';

class SignupCardFields extends StatelessWidget {
  const SignupCardFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 450.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: ColorsManager.backgroundWhite,
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.primary,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            heightSpace(10),
            const SignUpValidation(),
            heightSpace(10),
            const HaveAnAccount(haveAccount: true),
          ],
        ),
      ),
    );
  }
}
