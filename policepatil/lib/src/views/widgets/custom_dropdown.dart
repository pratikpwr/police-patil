import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

DropdownButton<String> buildDropButton(
    {String? value,
    required List<String> items,
    required String hint,
    required var onChanged}) {
  return DropdownButton<String>(
      focusColor: Colors.white,
      value: value,
      //elevation: 5,
      style: GoogleFonts.poppins(color: Colors.white),
      iconEnabledColor: Colors.black,
      items: items.map<DropdownMenuItem<String>>((String val) {
        return DropdownMenuItem<String>(
          value: val,
          child: Text(
            val,
            style: GoogleFonts.poppins(color: Colors.black),
          ),
        );
      }).toList(),
      hint: Text(
        hint,
        style: GoogleFonts.poppins(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: onChanged);
}
