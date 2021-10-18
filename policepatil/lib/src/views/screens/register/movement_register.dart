import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:policepatil/src/views/widgets/attach_button.dart';
import 'package:shared/shared.dart';

class MovementRegFormScreen extends StatefulWidget {
  const MovementRegFormScreen({Key? key}) : super(key: key);

  @override
  State<MovementRegFormScreen> createState() => _MovementRegFormScreenState();
}

class _MovementRegFormScreenState extends State<MovementRegFormScreen> {
  String? _movementValue;
  String? _movementSubValue;
  var _isIssue;
  List<String>? _movementSubRegTypes;

  Position? _position;
  double _longitude = 0.00;
  double _latitude = 0.00;

  String _photoName = "हालचालीचा फोटो जोडा";
  File? _photo;

  final TextEditingController _countController = TextEditingController();
  final TextEditingController _leaderController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  final List<String> _movementRegTypes = <String>[
    "राजकीय हालचाली",
    "धार्मिक हालचाली",
    "जातीय हालचाली",
    "सांस्कृतिक हालचाली"
  ];
  final List<String> _politicalMovements = <String>[
    "आंदोलने",
    "सभा",
    "निवडणुका",
    "इतर"
    // "राजकीय संघर्ष/वाद-विवाद"
  ];
  final List<String> _religionMovements = <String>[
    "यात्रा/उत्सव",
    "घेण्यात येणारे कार्यक्रम",
    "इतर"
    // "धार्मिक प्रसंगी उद्भवणारे वाद-विवाद"
  ];
  final List<String> _castMovements = <String>[
    "कार्यक्रम",
    "जातीय वाद-विवाद",
    "जातीय आंदोलने",
    "इतर"
  ];
  final List<String> _culturalMovements = <String>[
    "जयंती/पुण्यतिथी",
    "सण/उत्सव",
    "इतर सांस्कृतिक हालचाली"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MOVEMENT_REGISTER,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<MovementRegisterBloc, MovementRegisterState>(
        listener: (context, state) {
          if (state is MovementDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is MovementDataSent) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                spacer(),
                buildDropButton(
                    value: _movementValue,
                    items: _movementRegTypes,
                    hint: "हालचाली प्रकार निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        _movementValue = value;
                        _movementSubRegTypes = _getSubList(_movementValue);
                        _movementSubValue = null;
                      });
                    }),
                spacer(),
                _movementValue != null
                    ? buildDropButton(
                        value: _movementSubValue,
                        items: _movementSubRegTypes!,
                        hint: "हालचाली उपप्रकार निवडा",
                        onChanged: (String? value) {
                          setState(() {
                            _movementSubValue = value;
                          });
                        })
                    : spacer(height: 0),
                spacer(),
                buildTextField(_placeController, PLACE),
                spacer(),
                AttachButton(
                    text: SELECT_LOCATION,
                    icon: Icons.location_on_rounded,
                    onTap: () async {
                      _position = await determinePosition();
                      setState(() {
                        _longitude = _position!.longitude;
                        _latitude = _position!.latitude;
                      });
                    }),
                spacer(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("$LONGITUDE: $_longitude",
                        style: GoogleFonts.poppins(fontSize: 14)),
                    const SizedBox(width: 12),
                    Text("$LATITUDE: $_latitude",
                        style: GoogleFonts.poppins(fontSize: 14)),
                  ],
                ),
                spacer(),
                buildDateTextField(context, _dateController, DATE),
                spacer(),
                buildTimeTextField(context, _timeController, TIME),
                spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      IS_ISSUE,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: YES,
                                groupValue: _isIssue,
                                onChanged: (value) {
                                  setState(() {
                                    _isIssue = value;
                                  });
                                }),
                            Text(
                              YES,
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Row(
                          children: [
                            Radio(
                                value: NO,
                                groupValue: _isIssue,
                                onChanged: (value) {
                                  setState(() {
                                    _isIssue = value;
                                  });
                                }),
                            Text(
                              NO,
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                spacer(),
                buildTextField(
                    _leaderController, "नेतृत्त्व करणाऱ्या  व्यक्तीचे नाव"),
                spacer(),
                buildTextField(_countController, ATTENDANCE),
                spacer(),
                buildTextField(
                  _otherController,
                  MOVEMENT_DESCRIPTION,
                ),
                spacer(),
                AttachButton(
                  text: _photoName,
                  onTap: () async {
                    getFileFromDevice(context).then((pickedFile) {
                      setState(() {
                        _photo = pickedFile;
                        _photoName = getFileName(pickedFile!.path);
                      });
                    });
                  },
                ),
                spacer(),
                CustomButton(
                    text: DO_REGISTER,
                    onTap: () {
                      _registerMovementData();
                    }),
                spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _registerMovementData() {
    DateFormat _format = DateFormat("yyyy-MM-dd HH:mm");
    /* TODO : add leader field - can add multiple persons up to 5
              movement type - happened or going to happen
              use date option according to it
    */
    MovementData _movementData = MovementData(
        type: _movementValue,
        subtype: _movementSubValue,
        address: _placeController.text,
        latitude: _latitude,
        longitude: _longitude,
        datetime:
            _format.parse(_dateController.text + " " + _timeController.text),
        issue: _isIssue == YES ? true : false,
        attendance: int.parse(_countController.text),
        description: _otherController.text,
        photo: _photo?.path);

    BlocProvider.of<MovementRegisterBloc>(context)
        .add(AddMovementData(_movementData));
  }

  List<String> _getSubList(String? movementValue) {
    if (movementValue == "राजकीय हालचाली") {
      return _politicalMovements;
    } else if (movementValue == "धार्मिक हालचाली") {
      return _religionMovements;
    } else if (movementValue == "जातीय हालचाली") {
      return _castMovements;
    } else if (movementValue == "सांस्कृतिक हालचाली") {
      return _culturalMovements;
    } else {
      return ["अगोदर हालचाली प्रकार निवडा"];
    }
  }
}
