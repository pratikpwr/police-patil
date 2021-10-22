import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';

TextField buildTextField(TextEditingController _controller, String hint) {
  return TextField(
    controller: _controller,
    style: GoogleFonts.poppins(fontSize: 14),
    decoration: InputDecoration(
        focusColor: PRIMARY_COLOR,
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(hint, style: Styles.titleTextStyle()),
        hintStyle: Styles.titleTextStyle(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
  );
}
