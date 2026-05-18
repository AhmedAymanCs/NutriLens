import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/image_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/have_an_account.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/login_validation.dart';
import 'package:nutrilens/features/auth/presentation/login/presentation/widgets/login_with_social_media.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.1, 0.5, 0.9],
              colors: [
                ColorsManager.primaryLight,
                ColorsManager.primaryLight.withAlpha(100),
                ColorsManager.primary,
              ],
            ),
          ),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60.w,
                    height: 50.h,
                    padding: EdgeInsets.all(10.r),
                    margin: EdgeInsets.only(top: 20.h),
                    decoration: BoxDecoration(
                      color: ColorsManager.backgroundWhite,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Image.asset(
                      ImageManager.authLogoIcon,
                      fit: BoxFit.contain,
                      width: 30.w,
                      height: 30.h,
                    ),
                  ),
                  Text(
                    StringManager.appName,
                    style: AppTextStyle.font32PrimaryBold,
                  ),
                  Text(
                    StringManager.subTitleLoginPage1,
                    style: AppTextStyle.font13GreyW400,
                  ),
                  Text(
                    StringManager.subTitleLoginPage2,
                    style: AppTextStyle.font13GreyW400,
                  ),
                  heightSpace(10),
                  Text(
                    StringManager.subTitleLoginPage3,
                    style: AppTextStyle.font15GreyW500,
                  ),
                ],
              ),
              Container(
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
                    LoginValidation(),
                    heightSpace(10),
                    LoginWithSocialMedia(),
                    heightSpace(10),
                    HaveAnAccount(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
