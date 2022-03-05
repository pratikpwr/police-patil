import 'package:flutter/material.dart';

import '../../config/color_constants.dart';
import '../../utils/custom_methods.dart';
import '../../utils/styles.dart';

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
        style: Styles.inputFieldTextStyle(),
      ),
      spacer(height: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 1),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              focusColor: Colors.white,
              value: value,
              isExpanded: true,
              iconEnabledColor: PRIMARY_COLOR,
              iconSize: 30,
              items: items.map<DropdownMenuItem<String>>((String val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(
                    val,
                    style: Styles.inputFieldTextStyle(),
                  ),
                );
              }).toList(),
              hint: Text(
                hint,
                style: Styles.inputFieldTextStyle(),
              ),
              onChanged: onChanged),
        ),
      ),
    ],
  );
}
