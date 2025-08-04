import 'package:flutter/material.dart';

class CustomTextStyle {
  CustomTextStyle._();

  static TextStyle customTextStyle({
    double fontSize = 14.0,
    double? height,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontSize: fontSize,
      height: height ?? 1.0,
      color: color,
    );
  }

  static TextStyle textSuperHuge(BuildContext context) => customTextStyle(
        fontSize: 28.0,
        height: 1.43,
        color: Colors.white,
      );

  static TextStyle text20(BuildContext context) => customTextStyle(
        fontSize: 20.0,
        height: 1.33,
        color: Colors.white,
      );

  static TextStyle textHuge(BuildContext context) => customTextStyle(
        fontSize: 24.0,
        height: 1.33,
        color: Colors.white,
      );


// fontSize 18 - height 28 - color white
 
  static TextStyle textLarge(BuildContext context) => customTextStyle(
        fontSize: 18.0,
        height: 1.55,
        color: Colors.white,
      );


// fontSize 16 - height 24 - color white
 
  static TextStyle textNormal(BuildContext context) => customTextStyle(
        fontSize: 16.0,
        height: 1.5,
        color: Colors.white,
      );


// fontSize 14 - height 20 - color white

  static TextStyle textMedium(BuildContext context) => customTextStyle(
        fontSize: 14.0,
        height: 1.43,
        color: Colors.white,
      );


// fontSize 12 - height 16 - color white
 
  static TextStyle textSmall(BuildContext context) => customTextStyle(
        fontSize: 12.0,
        height: 1.5,
        color: Colors.white,
      );

  static TextStyle textTiny(BuildContext context) => customTextStyle(
        fontSize: 11.0,
        color: Colors.white,
      );

  static TextStyle text10(BuildContext context) => customTextStyle(
        fontSize: 10.0,
        color: Colors.white,
        height: 1.4,
      );
}
