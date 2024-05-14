import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mithub_app/design/colors.dart';

// Funding Design System Theme
// Implicitly implement Material 2 (2018)
ThemeData funDsTheme(BuildContext context) {
  final themeData = Theme.of(context);
  final textTheme = themeData.textTheme;
  final appBarTheme = themeData.appBarTheme;
  final iconTheme = themeData.iconTheme;

  // The default properties mapping from Material 3 -> 2
  // default_size(57) displayLarge -> headline1,
  // default_size(45) displayMedium -> headline2,
  // default_size(36) displaySmall -> headline3,
  // default_size(32) headlineLarge = N/A,
  // default_size(28) headlineMedium -> headline4,
  // default_size(24) headlineSmall -> headline5,
  // default_size(22) titleLarge -> headline6,
  // default_size(16) titleMedium -> subtitle1,
  // default_size(14) titleSmall -> subtitle2,
  // default_size(16) bodyLarge -> bodyLarge,
  // default_size(14) bodyMedium -> bodyText2,
  // default_size(12) bodySmall -> caption,
  // default_size(14) labelLarge -> button,
  // default_size(12) labelMedium = N/A,
  // default_size(11) labelSmall -> overline;
  final funDsTextTheme = GoogleFonts.interTextTheme(textTheme).copyWith(
    displayLarge: TextStyle(
      fontSize: 40.sp,
      fontWeight: FontWeight.w800,
    ),
    displayMedium: TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w800,
    ),
    displaySmall: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w800,
    ),
    headlineLarge: TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w800,
    ),
    headlineSmall: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w800,
    ),
    titleLarge: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w800,
    ),
    titleMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w800,
    ),
    titleSmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w800,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.sp,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
    ),
    labelLarge: TextStyle(
      fontSize: 14.sp,
    ),
    labelMedium: TextStyle(
      fontSize: 12.sp,
    ),
    labelSmall: TextStyle(
      fontSize: 11.sp,
    ),
  );

  ButtonThemeData buttonThemeData = ButtonThemeData(height: 44.h);
  Size buttonMinSize = Size(64.w, 44.h);

  final elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w800,
      ),
      minimumSize: buttonMinSize,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
    ),
  );

  final outlinedButtonThemeData = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w800,
        color: FunDsColors.neutralOne,
      ),
      minimumSize: buttonMinSize,
      side: BorderSide(
        style: BorderStyle.solid,
        width: 2.w,
        strokeAlign: -1.0,
        color: FunDsColors.primaryBase,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
    ),
  );

  final textButtonThemeData = TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: FunDsColors.primaryBase,
      ),
    ),
  );

  final iconThemeData = iconTheme.copyWith(
    color: FunDsColors.primaryBase,
  );

  final funDSAppBarTheme = appBarTheme.copyWith(
    titleTextStyle: textTheme.titleLarge,
  );

  return ThemeData(
    colorScheme: const ColorScheme.light(
      primary: FunDsColors.primaryBase,
      secondary: FunDsColors.primaryLight,
      tertiary: FunDsColors.primaryInvert,
      onPrimary: FunDsColors.white,
      onBackground: FunDsColors.neutralOne,
      error: FunDsColors.alert,
    ),
    useMaterial3: false,
    textTheme: funDsTextTheme,
    buttonTheme: buttonThemeData,
    elevatedButtonTheme: elevatedButtonThemeData,
    outlinedButtonTheme: outlinedButtonThemeData,
    textButtonTheme: textButtonThemeData,
    appBarTheme: funDSAppBarTheme,
    iconTheme: iconThemeData,
  );
}
