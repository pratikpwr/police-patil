import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../config/color_constants.dart';
import '../../utils/styles.dart';

TextField buildDateTextField(
    BuildContext context, TextEditingController _controller, String hint,
    {DateTime? minTime, DateTime? maxTime}) {
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
          DatePicker.showDatePicker(
            context,
            showTitleActions: true,
            minTime: minTime ?? DateTime(1999, 1, 1),
            maxTime: maxTime ?? DateTime(2100, 12, 31),
            onChanged: (date) {
              _controller.text =
                  "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            },
            onConfirm: (date) {
              _controller.text =
                  "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            },
            currentTime: DateTime.now(),
          );
        },
      ),
      hintText: "yyyy-mm-dd",
      label: Text(hint, style: Styles.inputFieldTextStyle()),
    ),
  );
}
