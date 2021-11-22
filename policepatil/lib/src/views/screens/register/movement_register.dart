import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:policepatil/src/views/widgets/attach_button.dart';
import 'package:shared/shared.dart';

class MovementRegFormScreen extends StatefulWidget {
  MovementRegFormScreen({Key? key, this.movementData}) : super(key: key);
  MovementData? movementData;

  @override
  State<MovementRegFormScreen> createState() => _MovementRegFormScreenState();
}

class _MovementRegFormScreenState extends State<MovementRegFormScreen> {
  Position? _position;
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _leaderController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  bool _isEdit = false;
  String? movementValue;
  String? timeValue;
  String? movementSubValue;
  var isIssue;
  List<String>? movementSubRegTypes;

  double longitude = 0.00;
  double latitude = 0.00;

  String photoName = "हालचालीचा फोटो जोडा";
  File? photo;
  final List<String> timeType = <String>["संभाव्य", "घटित"];
  final List<String> movementRegTypes = <String>[
    "राजकीय हालचाली",
    "धार्मिक हालचाली",
    "जातीय हालचाली",
    "सांस्कृतिक हालचाली"
  ];
  final List<String> politicalMovements = <String>[
    "आंदोलने",
    "सभा",
    "निवडणुका",
    "इतर"
    // "राजकीय संघर्ष/वाद-विवाद"
  ];
  final List<String> religionMovements = <String>[
    "यात्रा/उत्सव",
    "घेण्यात येणारे कार्यक्रम",
    "इतर"
    // "धार्मिक प्रसंगी उद्भवणारे वाद-विवाद"
  ];
  final List<String> castMovements = <String>[
    "कार्यक्रम",
    "जातीय वाद-विवाद",
    "जातीय आंदोलने",
    "इतर"
  ];
  final List<String> culturalMovements = <String>[
    "जयंती/पुण्यतिथी",
    "सण/उत्सव",
    "इतर सांस्कृतिक हालचाली"
  ];

  List<String> getSubList() {
    if (movementValue == "राजकीय हालचाली") {
      return politicalMovements;
    } else if (movementValue == "धार्मिक हालचाली") {
      return religionMovements;
    } else if (movementValue == "जातीय हालचाली") {
      return castMovements;
    } else if (movementValue == "सांस्कृतिक हालचाली") {
      return culturalMovements;
    } else {
      return ["अगोदर हालचाली प्रकार निवडा"];
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  _initializeValues() {
    /// checks is edit mode or not
    _isEdit = widget.movementData != null;

    movementValue = _isEdit ? widget.movementData?.type : null;
    movementSubRegTypes = getSubList();
    movementSubValue = _isEdit ? widget.movementData?.subtype : null;
    timeValue = _isEdit ? widget.movementData?.movementType : null;
    _dateController.text = _isEdit
        ? dateInYYYYMMDDFormat(widget.movementData!.datetime) ?? ''
        : '';
    _countController.text = _isEdit ? "${widget.movementData?.attendance}" : '';
    _leaderController.text = _isEdit ? widget.movementData?.leader ?? '' : '';
    _placeController.text = _isEdit ? widget.movementData?.address ?? '' : '';
    _otherController.text =
        _isEdit ? widget.movementData?.description ?? '' : '';
    isIssue = widget.movementData?.issue;
    photoName = _isEdit ? 'फोटो जोडलेले आहे' : 'फोटो जोडा';
    longitude = _isEdit ? widget.movementData?.longitude ?? 0.00 : 0.00;
    latitude = _isEdit ? widget.movementData?.latitude ?? 0.00 : 0.00;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MOVEMENT_REGISTER),
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
          if (state is MovementDataEdited) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
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
                    value: movementValue,
                    items: movementRegTypes,
                    hint: "हालचाली प्रकार निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        movementValue = value;
                        movementSubRegTypes = getSubList();
                        movementSubValue = null;
                      });
                    }),
                spacer(),
                movementValue != null
                    ? buildDropButton(
                        value: movementSubValue,
                        items: movementSubRegTypes!,
                        hint: "हालचाली उपप्रकार निवडा",
                        onChanged: (String? value) {
                          setState(() {
                            movementSubValue = value;
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
                        longitude = _position!.longitude;
                        latitude = _position!.latitude;
                      });
                    }),
                spacer(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("$LONGITUDE: ${longitude}",
                        style: GoogleFonts.poppins(fontSize: 14)),
                    const SizedBox(width: 12),
                    Text("$LATITUDE: ${latitude}",
                        style: GoogleFonts.poppins(fontSize: 14)),
                  ],
                ),
                spacer(),
                buildDropButton(
                    value: timeValue,
                    items: timeType,
                    hint: "हालचाली स्तिथी निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        timeValue = value;
                      });
                    }),
                spacer(),
                if (timeValue == "संभाव्य")
                  buildDateTextField(context, _dateController, DATE,
                      minTime: DateTime.now()),
                if (timeValue == "घटित")
                  buildDateTextField(context, _dateController, DATE,
                      maxTime: DateTime.now()),
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
                                groupValue: isIssue,
                                onChanged: (value) {
                                  setState(() {
                                    isIssue = value;
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
                                groupValue: isIssue,
                                onChanged: (value) {
                                  setState(() {
                                    isIssue = value;
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
                    _leaderController, "नेतृत्त्व करणाऱ्या व्यक्तीचे नाव"),
                spacer(),
                buildTextField(_countController, ATTENDANCE),
                spacer(),
                buildTextField(
                  _otherController,
                  MOVEMENT_DESCRIPTION,
                ),
                spacer(),
                AttachButton(
                  text: photoName,
                  onTap: () async {
                    getFileFromDevice(context).then((pickedFile) {
                      setState(() {
                        photo = pickedFile;
                        photoName = getFileName(pickedFile!.path);
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

  _registerMovementData() async {
    MovementData _movementData = MovementData(
        id: _isEdit ? widget.movementData?.id : null,
        type: movementValue,
        subtype: movementSubValue,
        movementType: timeValue,
        leader: _leaderController.text,
        address: _placeController.text,
        latitude: latitude,
        longitude: longitude,
        datetime: _isEdit
            ? parseDate(_dateController.text)
            : parseDate(_dateController.text + " " + _timeController.text,
                form: "yyyy-MM-dd HH:mm"),
        issue: isIssue == YES ? true : false,
        attendance: parseInt(_countController.text),
        description: _otherController.text,
        photo: photo?.path != null
            ? await MultipartFile.fromFile(photo!.path)
            : null);

    _isEdit
        ? BlocProvider.of<MovementRegisterBloc>(context)
            .add(EditMovementData(_movementData))
        : BlocProvider.of<MovementRegisterBloc>(context)
            .add(AddMovementData(_movementData));
  }
}
