import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: ColorsManager.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: ColorsManager.primary),
          onPressed: () {},
        ),
        title: Column(
          children: [
            Text(
              StringManager.appName,
              style: AppTextStyle.font24BlackW700.copyWith(color: ColorsManager.primary),
            ),
            Text(
              StringManager.homeSubTitle,
              style: AppTextStyle.font11BlackW600.copyWith(color: ColorsManager.gray500),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: ColorsManager.primary),
            onPressed: () {},
          ),
        ],
      );
  }
}