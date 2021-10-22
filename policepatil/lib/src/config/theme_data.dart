// copy from muse asia app
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';

/// contains theme data for app

final myTheme = ThemeData(
  primaryColor: ORANGE,
  iconTheme: const IconThemeData(color: PRIMARY_COLOR, size: 24),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: 2,
    color: Colors.white,
    actionsIconTheme: const IconThemeData(color: POLICE_BLUE, size: 24),
    iconTheme: const IconThemeData(color: POLICE_BLUE, size: 24),
    titleTextStyle: GoogleFonts.poppins(
        color: POLICE_BLUE, fontSize: 20, fontWeight: FontWeight.w600),
  ),
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: PRIMARY_COLOR),
);
