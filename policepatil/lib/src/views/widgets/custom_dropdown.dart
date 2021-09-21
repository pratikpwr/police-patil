import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/utils/custom_methods.dart';

Widget buildDropButton(
    {String? value,
    required List<String> items,
    required String hint,
    required var onChanged}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        hint,
        style: GoogleFonts.poppins(color: Colors.black),
      ),
      spacer(height: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 0.8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              focusColor: Colors.white,
              value: value,
              isExpanded: true,
              //elevation: 5,
              style: GoogleFonts.poppins(color: Colors.white),
              iconEnabledColor: Colors.black,
              iconSize: 30,
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
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: onChanged),
        ),
      ),
    ],
  );
}
