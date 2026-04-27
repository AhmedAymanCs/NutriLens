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
        // Container(
        //   width: 60.w,
        //   height: 50.h,
        //   padding: EdgeInsets.symmetric(horizontal: 10.w),
        //   margin: EdgeInsets.only(top: 20.h),
        //   decoration: BoxDecoration(
        //     color: ColorsManager.backgroundWhite,
        //     borderRadius: BorderRadius.circular(15.r),
        //   ),
        //   child: Image.asset(
        //     ImageManager.authLogoIcon,
        //     fit: BoxFit.contain,
        //     width: 30.w,
        //     height: 30.h,
        //   ),
        // ),
        Image.asset(
          ImageManager.logo,
          width: 100.w,
          height: 100.h,
          fit: BoxFit.contain,
        ),
        Text(StringManager.appName, style: AppTextStyle.font32PrimaryBold),
        isRegisterPage
            ? Text(
                StringManager.subTitleRegisterPage,
                style: AppTextStyle.font15GreyW500,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringManager.subTitleLoginPage1,
                    style: AppTextStyle.font13GreyW400,
                  ),
                  Text(
                    StringManager.subTitleLoginPage2,
                    style: AppTextStyle.font13GreyW400,
                  ),
                  Text(
                    StringManager.subTitleLoginPage3,
                    style: AppTextStyle.font15GreyW500,
                  ),
                ],
              ),
      ],
    );
  }
}
