import 'package:flutter/material.dart';

class AppTheme {
  /// Static Colors
  static const Color primaryColor = Color(0xFF0c4e8a);
  static const Color primaryLightColor = Color(0xFF79d2f6);
  static const Color secondaryColor = Color(0xFFF36F4A);
  static const Color secondaryColor2 = Color(0xFFf9c846);
  static const Color caregiversColorM1 = Color(0xFF532F90);
  static const Color caregiversColorM2 = Color(0xFFB51f8E);
  static const Color darkColor = Color(0xFF231F20);
  static const Color lightColor = Color(0xFFFFFFFF);
  static const Color successColor = Color(0xFF1B9E47);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color accentColor = Color(0xFFEED0A5);
  static const Color errorColor = Color(0xFFE74B4B);
  static const Color maroonColor2 = Color(0xFFD93A3A);
  static const Color greyColor = Color(0xFF70787D);
  static const Color greyTextColor = Color(0xFF475467);
  static const Color lightGreyColor = Color(0xFFE7E7ED);
  static const Color darkGreyColor = Color(0xFF4b4748);
  static const Color baseGreyColor = Color(0xFFE7EDF3);
  static const Color grey700Color = Color(0xFF1E1A1B);
  static const Color grey400Color = Color(0xFF747273);
  static const Color grey450Color = Color(0xFF9A9FA5);
  static const Color grey300Color = Color(0xFFa09f9f);
  static const Color grey200Color = Color(0xFFcac9c9);
  static const Color grey100Color = Color(0xFFe9e9e9);
  static const Color blue200Color = Color(0xFFC5D5E3);
  static const Color blue300Color = Color(0xFF97B3CD);
  static const Color blue400Color = Color(0xFF94AAC5);

  /// Gradient Colors
  static List<Color> primaryGradient = [
    const Color(0xFFE25332),
    const Color(0xFFE99F40),
  ];

  /// Theme Date
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    dividerTheme: const DividerThemeData(color: Colors.transparent),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      background: lightColor,
      error: errorColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: AppTheme.lightColor,
      backgroundColor: AppTheme.lightColor,
      modalBackgroundColor: AppTheme.lightColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightColor,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
    ),
    scaffoldBackgroundColor: AppTheme.lightColor,
    canvasColor: AppTheme.lightColor,
    useMaterial3: true,
    fontFamily: 'WorkSans',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.w900,
        fontFamily: "WorkSans",
        color: darkColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        fontFamily: "WorkSans",
        color: darkColor,
        // height: 1,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: darkColor,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: darkColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: darkColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.1,
        color: darkColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.4,
        //20px
        color: darkColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.1,
        color: darkColor,
      ),
    ),
  );

  /// custom text-theme style
  static TextStyle customFontStyle({
    double fontSize = 16,
    Color color = darkColor,
    FontWeight fontWeight = FontWeight.normal,
    double? lineHeight,
    double? letterSpacing,
    String? fontFamily = "WorkSans",
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight, height: lineHeight, decoration: textDecoration, letterSpacing: letterSpacing, fontFamily: fontFamily);
}
