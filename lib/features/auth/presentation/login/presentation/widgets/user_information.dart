import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/color_manager.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({
    super.key,
    required this.title,
    this.icon,
    this.width,
    this.height,
  });
  final String title;
  final IconData? icon;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 100,
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ColorsManager.primary,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: ColorsManager.primary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: ColorsManager.primary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              backgroundColor: ColorsManager.backgroundWhite,
              radius: 30,
              child: Icon(icon, color: ColorsManager.primary, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
