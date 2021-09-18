import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextField buildTextField(TextEditingController _controller, String hint) {
  return TextField(
    controller: _controller,
    style: GoogleFonts.poppins(fontSize: 14),
    decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
  );
}
