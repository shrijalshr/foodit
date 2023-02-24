// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class AppColor extends ThemeExtension<AppColor> {
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color darkGrey;
  final Color lightGrey;
  final Color mistGrey;
  final Color whiteSmoke;
  final Color white;
  final Color successColor;
  final Color errorColor;
  final Color infoColor;
  final Color warningColor;

  const AppColor({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.darkGrey,
    required this.lightGrey,
    required this.mistGrey,
    required this.whiteSmoke,
    required this.white,
    required this.successColor,
    required this.errorColor,
    required this.infoColor,
    required this.warningColor,
  });

  @override
  ThemeExtension<AppColor> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? darkGrey,
    Color? lightGrey,
    Color? mistGrey,
    Color? whiteSmoke,
    Color? white,
    Color? successColor,
    Color? errorColor,
    Color? infoColor,
    Color? warningColor,
  }) {
    return AppColor(
        primaryColor: primaryColor ?? this.primaryColor,
        secondaryColor: secondaryColor ?? this.secondaryColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        darkGrey: darkGrey ?? this.darkGrey,
        lightGrey: lightGrey ?? this.lightGrey,
        mistGrey: mistGrey ?? this.mistGrey,
        whiteSmoke: whiteSmoke ?? this.whiteSmoke,
        white: white ?? this.white,
        successColor: successColor ?? this.successColor,
        errorColor: errorColor ?? this.errorColor,
        infoColor: infoColor ?? this.infoColor,
        warningColor: warningColor ?? this.warningColor);
  }

  @override
  ThemeExtension<AppColor> lerp(ThemeExtension<AppColor>? other, double t) {
    if (other is! AppColor) return this;

    return AppColor(
      primaryColor:
          Color.lerp(primaryColor, other.primaryColor, t) ?? primaryColor,
      secondaryColor:
          Color.lerp(secondaryColor, other.secondaryColor, t) ?? secondaryColor,
      darkGrey: Color.lerp(darkGrey, other.darkGrey, t) ?? darkGrey,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      lightGrey: Color.lerp(lightGrey, other.lightGrey, t) ?? lightGrey,
      mistGrey: Color.lerp(mistGrey, other.mistGrey, t) ?? mistGrey,
      white: Color.lerp(white, other.white, t) ?? white,
      whiteSmoke: Color.lerp(whiteSmoke, other.whiteSmoke, t) ?? whiteSmoke,
      successColor:
          Color.lerp(successColor, other.successColor, t) ?? successColor,
      errorColor: Color.lerp(errorColor, other.errorColor, t) ?? errorColor,
      infoColor: Color.lerp(infoColor, other.infoColor, t) ?? infoColor,
      warningColor:
          Color.lerp(warningColor, other.warningColor, t) ?? warningColor,
    );
  }


  static const AppColor light =AppColor(primaryColor: primaryColor, secondaryColor: secondaryColor, backgroundColor: backgroundColor, darkGrey: darkGrey, lightGrey: lightGrey, mistGrey: mistGrey, whiteSmoke: whiteSmoke, white: white, successColor: successColor, errorColor: errorColor, infoColor: infoColor, warningColor: warningColor) 
}
