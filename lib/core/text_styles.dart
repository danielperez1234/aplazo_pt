import 'package:aplazo_pt/core/colors.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static TextStyle mainTextStyle({double? size, Color? color}) {
    return TextStyle(fontSize: size ?? 18, color: color ?? AppColors.textWhite);
  }

  static TextStyle titleTextStyle({double? size, Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: size ?? 28,
      color: color ?? AppColors.textWhite,
    );
  }

  static TextStyle headerTextStyle({double? size, Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: size ?? 28,
      color: color ?? AppColors.textWhite,
    );
  }

  static TextStyle subtitleTextStyle({double? size, Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: size ?? 24,
      color: color ?? AppColors.textWhite,
    );
  }
}
