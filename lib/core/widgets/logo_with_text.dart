import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/font_manager.dart';
import 'package:nutrilens/core/constants/image_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';

class LogoWithText extends StatelessWidget {
  final String text;
  const LogoWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(ImageManager.logo, fit: BoxFit.contain),
          heightSpace(10),
          Text(
            text,
            style: TextStyle(
              fontSize: FontSize.s14,
              color: ColorsManager.primary,
              fontWeight: FontWeightManager.light,
            ),
          ),
        ],
      ),
    );
  }
}
