import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

TextField buildTimeTextField(
    BuildContext context, TextEditingController _controller, String hint) {
  return TextField(
    controller: _controller,
    style: GoogleFonts.poppins(fontSize: 16),
    decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today_rounded),
          onPressed: () {
            DatePicker.showTimePicker(
              context,
              showTitleActions: true,
              onChanged: (date) {
                _controller.text = "${date.hour}:${date.minute}:${date.second}";
              },
              onConfirm: (date) {
                _controller.text = "${date.hour}:${date.minute}:${date.second}";
              },
              currentTime: DateTime.now(),
            );
          },
        ),
        hintText: "mm:hh",
        label: Text(hint,
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
        hintStyle:
            GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
  );
}
