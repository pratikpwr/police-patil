import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';

Widget villageSelectDropDown(
    {required List<String> list,
    String? selValue,
    required var onChanged,
    bool isPs = false}) {
  return DropdownSearch<String>(
      mode: Mode.MENU,
      showSearchBox: true,
      items: list,
      dropdownSearchDecoration: InputDecoration(
        hintStyle: Styles.inputFieldTextStyle(),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: PRIMARY_COLOR, width: 2),
            borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: isPs ? "पोलीस ठा." : "गाव",
      ),
      onChanged: onChanged,
      selectedItem: selValue);
}
