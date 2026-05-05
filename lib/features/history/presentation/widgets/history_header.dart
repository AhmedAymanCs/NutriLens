import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/app_text_style.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/string_manager.dart';
import 'package:nutrilens/core/utils/spacer.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.arrow_back_ios, color: ColorsManager.textBlack),
        widthSpace(105),
        Text(
          StringManager.history,
          style: AppTextStyle.font18BlackBold.copyWith(color: ColorsManager.textBlack),
        )
      ],
    );
  }
}
