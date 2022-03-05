import 'package:flutter/material.dart';

import '../../utils/styles.dart';

TextField buildTextField(TextEditingController _controller, String hint) {
  return TextField(
    controller: _controller,
    style: Styles.inputFieldTextStyle(),
    decoration: InputDecoration(
      label: Text(hint, style: Styles.inputFieldTextStyle()),
    ),
  );
}
