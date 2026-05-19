import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData icon;
  const CustomListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightSpace(16),
        SwitchListTile(
          dense: true,
          tileColor: ColorsManager.gray200,
          thumbIcon: WidgetStatePropertyAll(
            Icon(icon, color: ColorsManager.backgroundWhite),
          ),
          thumbColor: const WidgetStatePropertyAll(ColorsManager.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          title: Text(title, style: AppTextStyle.font16BlackBold),
          subtitle: Text(subtitle, style: AppTextStyle.font13GreyW400),

          value: value,
          onChanged: onChanged,
          activeThumbColor: ColorsManager.primary,
        ),
      ],
    );
  }
}
