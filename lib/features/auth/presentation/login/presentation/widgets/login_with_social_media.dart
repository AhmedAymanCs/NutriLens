import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/image_manager.dart';
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
              width: 70.w,
              child: Divider(color: ColorsManager.textSecondary),
            ),
            Text("Or sign in with", ), // style: AppTextStyle.font13Grey400
            SizedBox(
              width: 70.w,
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
                "Continue with Google",
                //style: AppTextStyle.font16PrimaryBold,
              ),
              Spacer(),
              Image.asset(
                ImageManager.authGoogleIcon,
                width: 20.w,
                height: 20.h,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        // Center(
        //   child: SizedBox(
        //     width: 280.w,
        //     child: Text.rich(
        //       TextSpan(
        //         text: "By logging, you agree to our ",
        //         style: AppTextStyle.font13Grey400.copyWith(fontSize: 11.sp),
        //         children: [
        //           TextSpan(
        //             text: " Terms & Conditions",
        //             style: AppTextStyle.font11Black600,
        //           ),
        //           TextSpan(
        //             text: " and ",
        //             style: AppTextStyle.font13Grey400.copyWith(fontSize: 11.sp),
        //           ),
        //           TextSpan(
        //             text: " PrivacyPolicy.",
        //             style: AppTextStyle.font11Black600,
        //           ),
        //         ],
        //       ),
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
