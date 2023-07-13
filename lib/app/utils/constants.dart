import 'package:flutter/material.dart';

TextStyle myTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  TextDecoration? decoration,
  Color? decorationColor,
}) =>
    TextStyle(
      fontFamily: 'Inter',
      fontSize: fontSize ?? 13,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? Colors.white,
      decoration: decoration,
      decorationColor: decorationColor,
    );
