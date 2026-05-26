import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/string_manager.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Column(
        children: [
          Text(
            StringManager.appName,
            style: AppTextStyle.font24BlackW700(context),
          ),
          Text(
            StringManager.homeSubTitle,
            style: AppTextStyle.font11BlackW600(context),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
