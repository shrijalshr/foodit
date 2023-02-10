// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class AppColor extends ThemeExtension<AppColor> {
  ///Brand Colors
  final Color primaryColor;
  final Color textMutedColor;

  ///darkColor is dark blue
  final Color darkColor;

  ///darkMutedColor is darker blue. Kinda black
  final Color darkMutedColor;

  ///Teritary Colors
  final Color greySmoke;
  final Color greenMist;
  final Color whiteWater;

  //Background Colors
  ///background1 = White
  final Color background1;

  ///background2 is white smoke
  final Color background2;

  //State Colors
  final Color infoColor;
  final Color successColor;
  final Color warningColor;
  final Color errorColor;

  const AppColor({
    required this.textMutedColor,
    required this.darkColor,
    required this.darkMutedColor,
    required this.primaryColor,
    required this.greySmoke,
    required this.greenMist,
    required this.whiteWater,
    required this.background1,
    required this.background2,
    required this.infoColor,
    required this.errorColor,
    required this.successColor,
    required this.warningColor,
  });

  @override
  ThemeExtension<AppColor> copyWith({
    Color? textMutedColor,
    Color? darkColor,
    Color? darkMutedColor,
    Color? primaryColor,
    Color? background1,
    Color? background2,
    Color? infoColor,
    Color? errorColor,
    Color? successColor,
    Color? warningColor,
    Color? greySmoke,
    Color? greenMist,
    Color? whiteWater,
  }) {
    return AppColor(
      textMutedColor: textMutedColor ?? this.textMutedColor,
      darkColor: darkColor ?? this.darkColor,
      darkMutedColor: darkMutedColor ?? this.darkMutedColor,
      primaryColor: primaryColor ?? this.primaryColor,
      background1: background1 ?? this.background1,
      background2: background2 ?? this.background2,
      infoColor: infoColor ?? this.infoColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      greenMist: greenMist ?? this.greenMist,
      greySmoke: greySmoke ?? this.greySmoke,
      whiteWater: whiteWater ?? this.whiteWater,
    );
  }

  @override
  ThemeExtension<AppColor> lerp(ThemeExtension<AppColor>? other, double t) {
    if (other is! AppColor) return this;

    return AppColor(
      textMutedColor:
          Color.lerp(textMutedColor, other.textMutedColor, t) ?? textMutedColor,
      darkColor: Color.lerp(darkColor, other.darkColor, t) ?? darkColor,
      darkMutedColor:
          Color.lerp(darkMutedColor, other.darkMutedColor, t) ?? darkMutedColor,
      primaryColor:
          Color.lerp(primaryColor, other.primaryColor, t) ?? primaryColor,
      background1: Color.lerp(background1, other.background1, t) ?? background1,
      background2: Color.lerp(background2, other.background2, t) ?? background2,
      infoColor: Color.lerp(infoColor, other.infoColor, t) ?? infoColor,
      errorColor: Color.lerp(errorColor, other.errorColor, t) ?? errorColor,
      successColor:
          Color.lerp(successColor, other.successColor, t) ?? successColor,
      warningColor:
          Color.lerp(warningColor, other.warningColor, t) ?? warningColor,
      greenMist: Color.lerp(greenMist, other.greenMist, t) ?? greenMist,
      greySmoke: Color.lerp(greySmoke, other.greySmoke, t) ?? greySmoke,
      whiteWater: Color.lerp(whiteWater, other.whiteWater, t) ?? whiteWater,
    );
  }

  ///For [LightTheme]
  static const light = AppColor(
    primaryColor: Color.fromARGB(255, 255, 138, 48),
    background1: Color(0xffffffff),
    background2: Color(0xffF6F6F6),
    infoColor: Color(0xff2f80ed),
    successColor: Color(0xff11c343),
    warningColor: Color(0xffee961b),
    errorColor: Color(0xfffc4141),
    darkColor: Color(0xff201237),
    darkMutedColor: Color(0xff181725),
    textMutedColor: Color(0xff484849),
    greenMist: Color(0xffEAEAEA),
    greySmoke: Color(0xff98A2B3),
    whiteWater: Color(0xffF3F4F8),
  );

  ///For [DarkTheme]
  static const dark = AppColor(
    primaryColor: Color(0xffEE2F2F),
    background1: Color(0xffffffff),
    background2: Color(0xffF6F6F6),
    infoColor: Color(0xff2f80ed),
    successColor: Color(0xff11c343),
    warningColor: Color(0xffee961b),
    errorColor: Color(0xfffc4141),
    darkColor: Color(0xff201237),
    darkMutedColor: Color(0xff181725),
    textMutedColor: Color(0xff484849),
    greenMist: Color(0xffEAEAEA),
    greySmoke: Color(0xff98A2B3),
    whiteWater: Color(0xffF3F4F8),
  );
}
