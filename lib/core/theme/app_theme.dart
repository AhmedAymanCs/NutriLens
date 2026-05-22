import 'package:flutter/material.dart';
import 'package:nutrilens/core/constants/color_manager.dart';
import 'package:nutrilens/core/constants/font_manager.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: ColorsManager.primary,
      secondary: ColorsManager.gray500,
      surface: ColorsManager.backgroundWhite,
      onPrimary: ColorsManager.textLight,
      onSecondary: ColorsManager.textLight,
    ),
    scaffoldBackgroundColor: ColorsManager.background,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.backgroundWhite,
      elevation: 0,
      iconTheme: const IconThemeData(color: ColorsManager.textPrimary),
      titleTextStyle: TextStyle(
        color: ColorsManager.textHeading,
        fontSize: FontSize.s20,
        fontWeight: FontWeightManager.bold,
      ),
    ),
    textTheme: TextTheme(
      // Display
      displayLarge: TextStyle(
        fontSize: FontSize.s35,
        fontWeight: FontWeightManager.bold,
        color: ColorsManager.textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: FontSize.s28,
        fontWeight: FontWeightManager.bold,
        color: ColorsManager.textPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: FontSize.s24,
        fontWeight: FontWeightManager.bold,
        color: ColorsManager.textPrimary,
      ),
      // Headline
      headlineLarge: TextStyle(
        fontSize: FontSize.s22,
        fontWeight: FontWeightManager.bold,
        color: ColorsManager.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: FontSize.s20,
        fontWeight: FontWeightManager.semiBold,
        color: ColorsManager.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: FontSize.s18,
        fontWeight: FontWeightManager.semiBold,
        color: ColorsManager.textPrimary,
      ),
      // Title
      titleLarge: TextStyle(
        fontSize: FontSize.s16,
        fontWeight: FontWeightManager.semiBold,
        color: ColorsManager.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: FontSize.s14,
        fontWeight: FontWeightManager.medium,
        color: ColorsManager.textPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: FontSize.s12,
        fontWeight: FontWeightManager.medium,
        color: ColorsManager.textSecondary,
      ),
      // Body
      bodyLarge: TextStyle(
        fontSize: FontSize.s16,
        fontWeight: FontWeightManager.regular,
        color: ColorsManager.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: FontSize.s14,
        fontWeight: FontWeightManager.regular,
        color: ColorsManager.textPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: FontSize.s12,
        fontWeight: FontWeightManager.regular,
        color: ColorsManager.textSecondary,
      ),
      // Label
      labelLarge: TextStyle(
        fontSize: FontSize.s14,
        fontWeight: FontWeightManager.semiBold,
        color: ColorsManager.textPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: FontSize.s12,
        fontWeight: FontWeightManager.medium,
        color: ColorsManager.textSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: FontSize.s10,
        fontWeight: FontWeightManager.regular,
        color: ColorsManager.textMuted,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.primary,
        foregroundColor: ColorsManager.textLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: TextStyle(
          fontSize: FontSize.s16,
          fontWeight: FontWeightManager.bold,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsManager.backgroundLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: ColorsManager.gray200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: ColorsManager.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: ColorsManager.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: ColorsManager.error, width: 2),
      ),
      hintStyle: TextStyle(
        color: ColorsManager.textMuted,
        fontSize: FontSize.s14,
        fontWeight: FontWeightManager.regular,
      ),
      errorStyle: TextStyle(
        color: ColorsManager.error,
        fontSize: FontSize.s12,
        fontWeight: FontWeightManager.regular,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    cardTheme: CardThemeData(
      color: ColorsManager.backgroundWhite,
      elevation: 2,
      shadowColor: ColorsManager.overlayBlack10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    dividerTheme: const DividerThemeData(
      color: ColorsManager.divider,
      thickness: 1,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorsManager.primary;
        }
        return ColorsManager.backgroundLight;
      }),
      checkColor: WidgetStateProperty.all(ColorsManager.textLight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: const BorderSide(color: ColorsManager.gray200),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121412), 
    
    colorScheme: const ColorScheme.dark(
      primary: ColorsManager.primary,
      secondary: ColorsManager.gray500,
      surface: Color(0xFF1C201D), 
      onPrimary: ColorsManager.textLight,
      onSurface: ColorsManager.textLight, 
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF121412),
      elevation: 0,
      iconTheme: const IconThemeData(color: ColorsManager.textLight),
      titleTextStyle: TextStyle(
        color: ColorsManager.textLight,
        fontSize: FontSize.s20,
        fontWeight: FontWeightManager.bold,
      ),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: FontSize.s35, fontWeight: FontWeightManager.bold, color: ColorsManager.textLight),
      headlineMedium: TextStyle(fontSize: FontSize.s20, fontWeight: FontWeightManager.semiBold, color: ColorsManager.textLight),
      bodyLarge: TextStyle(fontSize: FontSize.s16, color: ColorsManager.textLight),
      bodyMedium: TextStyle(fontSize: FontSize.s14, color: ColorsManager.textLight.withOpacity(0.7)),
      titleSmall: TextStyle(fontSize: FontSize.s12, color: ColorsManager.textMuted),
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF1C201D),
      elevation: 0, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF252A26),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      hintStyle: TextStyle(color: ColorsManager.textMuted, fontSize: FontSize.s14),
    ),

    dividerTheme: DividerThemeData(
      color: ColorsManager.gray500.withOpacity(0.2),
      thickness: 1,
    ),
  );
}
