import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/have_an_account.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/login_validation.dart';

class LoginCardFields extends StatelessWidget {
  const LoginCardFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: Column(
        children: [
          heightSpace(10),
          const LoginValidation(),
          heightSpace(10),
          const HaveAnAccount(),
        ],
      ),
    );
  }
}
