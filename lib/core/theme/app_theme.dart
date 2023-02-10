import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColor.light.darkColor,
        foregroundColor: AppColor.light.background1,
        iconTheme: IconThemeData(color: AppColor.light.background1),
        centerTitle: false,
        titleTextStyle: textTheme.displayLarge!.apply(
          color: AppColor.light.background1,
          // fontSizeDelta: 18,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColor.light.darkColor,
        )),
    primaryColor: AppColor.light.primaryColor,
    scaffoldBackgroundColor: AppColor.light.background2,
    textTheme: textTheme,
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStatePropertyAll(AppColor.light.primaryColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
    ),
    extensions: const <ThemeExtension<dynamic>>[
      AppColor.light,
    ],
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColor.light.primaryColor,
        surface: AppColor.light.background1,
        onSurface: AppColor.light.background1,
        error: AppColor.light.errorColor,
        background: AppColor.light.background2,
        onBackground: AppColor.light.background2,
        onPrimary: AppColor.light.primaryColor,
        secondary: AppColor.light.darkColor,
        onError: AppColor.light.errorColor,
        onSecondary: AppColor.light.darkColor),
  );

  static TextTheme textTheme = TextTheme(
    headlineLarge: GoogleFonts.rubik(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColor.light.darkMutedColor,
    ),
    headlineMedium: GoogleFonts.rubik(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColor.light.darkMutedColor,
    ),
    displayLarge: GoogleFonts.rubik(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColor.light.darkMutedColor,
    ),
    displayMedium: GoogleFonts.rubik(
      fontSize: 14,
      height: 1.5,
      fontWeight: FontWeight.w500,
      color: AppColor.light.darkMutedColor,
    ),
    bodyMedium: GoogleFonts.rubik(
      fontSize: 12,
      height: 1.5,
      fontWeight: FontWeight.w400,
      color: AppColor.light.greySmoke,
    ),
    bodySmall: GoogleFonts.rubik(
      fontSize: 10,
      height: 1.5,
      fontWeight: FontWeight.w400,
      color: AppColor.light.greySmoke,
    ),
    titleLarge: GoogleFonts.rubik(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.light.textMutedColor,
    ),
    titleMedium: GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.light.textMutedColor,
    ),
    labelLarge: GoogleFonts.rubik(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColor.light.background1,
    ),
  );
}
