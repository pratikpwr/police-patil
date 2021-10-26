import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';

TextField buildTimeTextField(
    BuildContext context, TextEditingController _controller, String hint) {
  return TextField(
    controller: _controller,
    style: Styles.inputFieldTextStyle(),
    decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.calendar_today_rounded,
            color: PRIMARY_COLOR,
          ),
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
        hintText: "hh:mm",
        label: Text(hint, style: Styles.inputFieldTextStyle())),
  );
}
