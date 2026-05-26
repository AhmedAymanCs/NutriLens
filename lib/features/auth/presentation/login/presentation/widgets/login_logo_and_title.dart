import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/image_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';

class LoginLogoAndTitle extends StatelessWidget {
  const LoginLogoAndTitle({super.key, this.isRegisterPage = false});
  final bool isRegisterPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          ImageManager.logo,
          width: 100.w,
          height: 100.h,
          fit: BoxFit.contain,
        ),
        Text(StringManager.appName, style: AppTextStyle.font32PrimaryBold),
        isRegisterPage
            ? Text(
                StringManager.subTitleLoginPage1,
                style: AppTextStyle.font15GreyW500(context),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringManager.subTitleLoginPage1,
                    style: AppTextStyle.font13GreyW400(context),
                  ),
                  Text(
                    StringManager.subTitleLoginPage2,
                    style: AppTextStyle.font13GreyW400(context),
                  ),
                  Text(
                    StringManager.subTitleLoginPage3,
                    style: AppTextStyle.font15GreyW500(context),
                  ),
                ],
              ),
      ],
    );
  }
}
