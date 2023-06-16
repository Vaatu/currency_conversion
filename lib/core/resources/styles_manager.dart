import 'package:flutter/material.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(fontSize: fontSize, fontFamily: fontFamily, color: color, fontWeight: fontWeight);
}
// get regular
TextStyle getRegularStyle(
    {double fontSize = FontSize.s14, String fontFamily = FontConstants.fontFamily, required Color color}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.regular, color);
}
/// Get light fontWeight text style
TextStyle getLightStyle(
    {double fontSize = FontSize.s14, String fontFamily = FontConstants.fontFamily, required Color color}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.light, color);
}
///bold  fontWeight text style
TextStyle getBoldStyle(
    {double fontSize = FontSize.s14, String fontFamily = FontConstants.fontFamily, required Color color}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.bold, color);
}

/// Semi bold  fontWeight text style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s14, String fontFamily = FontConstants.fontFamily, required Color color}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.semiBold, color);
}
/// Semi bold  fontWeight text style
TextStyle getMediumStyle(
    {double fontSize = FontSize.s14, String fontFamily = FontConstants.fontFamily, required Color color}) {
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.medium, color);
}