import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';

class Styles {
  static TextStyle primaryTextStyle({
    Color color = PRIMARY_COLOR,
    FontWeight fontWeight = FontWeight.w500,
    double fontSize = 16,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  static TextStyle appBarTextStyle({
    Color color = Colors.white,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 18,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  static TextStyle textButtonTextStyle({
    Color color = PRIMARY_COLOR,
    FontWeight fontWeight = FontWeight.w500,
    double fontSize = 16,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  static TextStyle titleTextStyle({
    Color color = TEXT_COLOR_TITLE,
    FontWeight fontWeight = FontWeight.w500,
    double fontSize = 15,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  static TextStyle subTitleTextStyle({
    Color color = TEXT_COLOR_SUBTITLE,
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }
}
