import 'package:flutter/material.dart';

class ColorManager {
  static const Color primary = Color(0xff030319);
  static const Color grey1 = Color(0xff667085);
  static const Color lightGrey = Color(0xffA1A4B5);
  static const Color lightGrey2 = Color(0xffF2F2F2);
  static const Color white = Color(0xffFFFFFF);
  static const Color darkWhite = Color(0xffB7BEC0);
  static const Color green = Color(0xff4CD080);
}

class ColorMatrix {
   static const List<double> darkerImageMatrix = [
    // Matrix values for brightness adjustment
    1, 0, 0, 0, 0,  // Red channel
    0, 1, 0, 0, 0,  // Green channel
    0, 0, 1, 0, 0,  // Blue channel
    0, 0, 0, 10, 0,  // Alpha channel
  ];
}
