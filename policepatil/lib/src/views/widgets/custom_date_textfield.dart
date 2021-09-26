import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

TextField buildDateTextField(
    BuildContext context, TextEditingController _controller, String hint) {
  return TextField(
    controller: _controller,
    style: GoogleFonts.poppins(fontSize: 14),
    decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today_rounded),
          onPressed: () {
            DatePicker.showDatePicker(
              context,
              showTitleActions: true,
              minTime: DateTime(2018, 1, 1),
              maxTime: DateTime(2032, 12, 31),
              onChanged: (date) {
                _controller.text = "${date.year}-${date.month}-${date.day}";
              },
              onConfirm: (date) {
                _controller.text = "${date.year}-${date.month}-${date.day}";
              },
              currentTime: DateTime.now(),
            );
          },
        ),
        hintText: "dd/mm/yyyy",
        label: Text(hint,
            style:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
        hintStyle:
            GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
  );
}
