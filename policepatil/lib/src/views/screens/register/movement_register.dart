import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';

class MovementRegScreen extends StatefulWidget {
  const MovementRegScreen({Key? key}) : super(key: key);

  @override
  State<MovementRegScreen> createState() => _MovementRegScreenState();
}

class _MovementRegScreenState extends State<MovementRegScreen> {
  String? _movementValue;
  String? _movementSubValue;
  var _isIssue;
  final List<String> _movementRegTypes = <String>[
    "राजकीय हालचाली",
    "धार्मिक हालचाली",
    "जातीय हालचाली",
    "सांस्कृतिक हालचाली"
  ];

  List<String>? _movementSubRegTypes;

  final List<String> _politicalMovements = <String>[
    "आंदोलने",
    "सभा",
    "निवडणुका",
    // "राजकीय संघर्ष/वाद-विवाद"
  ];
  final List<String> _religionMovements = <String>[
    "यात्रा/उत्सव",
    "घेण्यात येणारे कार्यक्रम",
    // "धार्मिक प्रसंगी उद्भवणारे वाद-विवाद"
  ];
  final List<String> _castMovements = <String>["कार्यक्रम", "जातीय वाद-विवाद"];
  final List<String> _culturalMovements = <String>[
    "जयंती/पुण्यतिथी",
    "सण/उत्सव",
    "इतर सांस्कृतिक हालचाली"
  ];
  Position? _position;
  String _selectedDateTime = "वेळ आणि तारीख";
  String _longitude = LONGITUDE;
  String _latitude = LATITUDE;
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

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
      body: SafeArea(
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
              CustomButton(
                  text: SELECT_LOCATION,
                  onTap: () async {
                    _position = await determinePosition();
                    setState(() {
                      _longitude = _position!.longitude.toString();
                      _latitude = _position!.latitude.toString();
                    });
                  }),
              spacer(),
              Text("$LONGITUDE: $_longitude",
                  style: GoogleFonts.poppins(fontSize: 16)),
              spacer(),
              Text("$LATITUDE: $_latitude",
                  style: GoogleFonts.poppins(fontSize: 16)),
              spacer(),
              CustomButton(
                onTap: () {
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2021, 1, 1),
                    maxTime: DateTime(2021, 12, 31),
                    onChanged: (date) {
                      setState(() {
                        _selectedDateTime = dateInFormat(date);
                      });
                    },
                    onConfirm: (date) {
                      setState(() {
                        _selectedDateTime = dateInFormat(date);
                      });
                    },
                    currentTime: DateTime.now(),
                  );
                },
                text: 'वेळ आणि तारीख निवडा',
              ),
              spacer(),
              Text(_selectedDateTime, style: GoogleFonts.poppins(fontSize: 16)),
              spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "काही वाद आहेत का ?",
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
                _otherController,
                "घटनेची सविस्तर माहिती",
              ),
              spacer(),
              CustomButton(
                  text: "रजिस्टर करा",
                  onTap: () {
                    showSnackBar(context, "सेव झाले");
                    Future.delayed(const Duration(seconds: 1)).then((_) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                        return const RegisterScreen();
                      }));
                    });
                  })
            ],
          ),
        ),
      ),
    );
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
