import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/image_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';

class LoginWithSocialMedia extends StatelessWidget {
  const LoginWithSocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 50.w,
              child: Divider(color: ColorsManager.textSecondary),
            ),
            Text(
              StringManager.orContinueWith,
            ), // style: AppTextStyle.font13Grey400
            SizedBox(
              width: 50.w,
              child: const Divider(color: ColorsManager.textSecondary),
            ),
          ],
        ),
        heightSpace(10),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            shadowColor: ColorsManager.primary,
            side: const BorderSide(color: ColorsManager.primary),
            elevation: 10,
            minimumSize: Size(double.infinity, 50.h),
            backgroundColor: ColorsManager.backgroundWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.r),
            ),
          ),
          child: Row(
            children: [
              Text(
                StringManager.continueWithGoogle,
                style: AppTextStyle.font16PrimaryBold,
              ),
              Spacer(),
              Image.asset(
                ImageManager.authGoogleIcon,
                width: 25.w,
                height: 25.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
