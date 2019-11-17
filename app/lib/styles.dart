import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Color blackColor = Color(0xFF000000);
const Color greyColor = Color(0xFFBBBBBB);
const Color whiteColor = Color(0xFFFFFFFF);

const Color textColor = Color(0xFF212121);

///#FF8733
const Color orangeColor = Color(0xFFFF8733);

///#1DB954
const Color greenColor = Color(0xFF1DB954);

///#4B35B0
const Color blueColor = Color(0xFF4B35B0);

const double smallSize = 10;
const double normalSize = 14;
const double bigSize = 18;

const FontWeight lightWeight = FontWeight.w300;
const FontWeight normalWeight = FontWeight.normal;
const FontWeight mediumWeight = FontWeight.w500;
const FontWeight boldWeight = FontWeight.bold;

const String ntrFontFamily = "NTR";
const String robotoFontFamily = "Roboto";

TextStyle genTextStyle(
    [Color color = textColor,
    double size = normalSize,
    FontWeight weight = normalWeight,
    String family = robotoFontFamily,
    double height]) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: weight,
    fontFamily: family,
    height: height,
  );
}
