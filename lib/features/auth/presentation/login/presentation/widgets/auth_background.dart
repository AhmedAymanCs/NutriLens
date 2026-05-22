import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/color_manager.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: child,
    );
  }
}
