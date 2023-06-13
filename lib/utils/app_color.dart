import 'package:flutter/material.dart';

class AppColors{
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color orangeColor = Colors.orange;
  static Color LightGreyColor = Colors.grey[100]!;
  hexStringToColor(String hexColor){
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6){
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

}