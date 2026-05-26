import 'package:flutter/material.dart';

class ColorsManager {
  // Primary
  static const Color primary = Color(0xFF2B694D);
  static const Color primaryLight = Color(0xFFB0F1CC);

  // Backgrounds
  static const Color background = Color(0xFFF7FAF5);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF2F5F1);
  static const Color backgroundLightDark = Color(0xFF1E1E1E);

  // Text
  static const Color textPrimary = Color(0xFF2B352F);
  static const Color textPrimaryDark = Color(0xFFE6F0EA);
  static const Color textSecondary = Color(0xFF58615B);
  static const Color textSecondaryDark = Color(0xFFADB5B0);
  static const Color textHeading = Color(0xFF2B352F);
  static const Color textHeadingDark = Color(0xFFECF3EE);
  static const Color textMuted = Color(0xFF9AA09C);
  static const Color textMutedDark = Color(0xFF6B736E);
  static const Color textLight = Color(0xFFFFFFFF);

  // Grays
  static const Color gray200 = Color(0xFFE0E4E1);
  static const Color gray200Dark = Color(0xFF2C2C2C);
  static const Color gray500 = Color(0xFF58615B);

  // Status
  static const Color success = Color(0xFF34A853);
  static const Color error = Color(0xFFEA4335);
  static const Color warning = Color(0xFFFBBC05);
  static const Color info = Color(0xFF4285F4);

  // Misc
  static const Color divider = Color(0xFFE0E4E1);
  static const Color dividerDark = Color(0xFF2A2A2A);
  static const Color overlayBlack10 = Color(0x1A000000);

  // Macro progress colors
  static const Color protein = Color(0xff884F47);
  static const Color carbs = Color(0xFF4C6456);
  static const Color textBlack = Color(0xFF191C1D);

  // Dynamic helpers
  static Color adaptiveBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? backgroundDark
      : background;

  static Color adaptiveCard(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? backgroundLightDark
      : backgroundWhite;

  static Color adaptiveTextHeading(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? textHeadingDark
      : textHeading;

  static Color adaptiveTextSecondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? textSecondaryDark
      : textSecondary;

  static Color adaptiveTextMuted(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? textMutedDark
      : textMuted;

  static Color adaptiveDivider(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dividerDark : divider;

  static Color adaptiveGray200(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? gray200Dark : gray200;
}
