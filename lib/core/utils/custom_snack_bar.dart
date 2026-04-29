import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';

void customSnackBar({
  required BuildContext context,
  required String message,
  bool isErrorMessage = true,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(bottom: 30.h, right: 15.w, left: 15.w),
      behavior: SnackBarBehavior.floating,
      elevation: 20,
      clipBehavior: Clip.none,
      backgroundColor: isErrorMessage
          ? ColorsManager.error.withAlpha(200)
          : ColorsManager.primary.withAlpha(200),
      content: Row(
        children: [
          Icon(
            isErrorMessage
                ? CupertinoIcons.info_circle
                : CupertinoIcons.checkmark_seal,
            color: ColorsManager.backgroundWhite,
          ),
          widthSpace(10),
          Expanded(child: Text(message, style: AppTextStyle.font16WhiteW600)),
        ],
      ),
    ),
  );
}
