import 'package:flutter/material.dart';

class AppColors {
  static const primary = HexColor("#003AD5");
  static const secondary = HexColor("#E65F5C");
  static const text = HexColor("#001347");
  static const par = HexColor("#767D85");
  static const stroke = HexColor("#B3E8E8E8");
  static const bgLight = HexColor("#FAFBFF");
  static const error = HexColor("#F1002E");
}

class HexColor {
  final String hex;
  const HexColor(this.hex);

  Color call() => Color(int.parse(hex.replaceFirst("#", "0xFF")));
}
