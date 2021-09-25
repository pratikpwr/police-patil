import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:policepatil/src/views/widgets/attach_button.dart';

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
  String _longitude = LONGITUDE;
  String _latitude = LATITUDE;

  String _photoName = "हालचालीचा फोटो जोडा";
  File? _photoImage;
  final picker = ImagePicker();

  final TextEditingController _countController = TextEditingController();
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
              AttachButton(
                  text: SELECT_LOCATION,
                  icon: Icons.location_on_rounded,
                  onTap: () async {
                    _position = await determinePosition();
                    setState(() {
                      _longitude = _position!.longitude.toString();
                      _latitude = _position!.latitude.toString();
                    });
                  }),
              spacer(),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("$LONGITUDE: $_longitude",
                      style: GoogleFonts.poppins(fontSize: 16)),
                  const SizedBox(width: 12),
                  Text("$LATITUDE: $_latitude",
                      style: GoogleFonts.poppins(fontSize: 16)),
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
              buildTextField(_countController, "उपस्थित लोकसंख्या"),
              spacer(),
              buildTextField(
                _otherController,
                "घटनेची सविस्तर माहिती",
              ),
              spacer(),
              AttachButton(
                text: _photoName,
                onTap: () {
                  getImage(context, _photoImage);
                },
              ),
              spacer(),
              CustomButton(
                  text: "रजिस्टर करा",
                  onTap: () {
                    showSnackBar(context, "सेव झाले");
                    Future.delayed(const Duration(seconds: 1)).then((_) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                            return const RegisterMenuScreen();
                      }));
                    });
                  }),
              spacer()
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

  Future getImage(BuildContext ctx, File? _image) async {
    await showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'फोटो काढा अथवा गॅलरी मधून निवडा',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    final pickedImage =
                        await picker.pickImage(source: ImageSource.camera);
                    setState(() {
                      if (pickedImage != null) {
                        _image = File(pickedImage.path);
                      } else {
                        debugPrint('No image selected.');
                      }
                    });
                    Navigator.pop(ctx);
                  },
                  child: Text(
                    'कॅमेरा',
                    style: GoogleFonts.poppins(fontSize: 14),
                  )),
              TextButton(
                  onPressed: () async {
                    final pickedImage =
                        await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      if (pickedImage != null) {
                        _image = File(pickedImage.path);
                      } else {
                        debugPrint('No image selected.');
                      }
                    });
                    Navigator.pop(ctx);
                  },
                  child: Text(
                    'गॅलरी',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ))
            ],
          );
        });
  }
}
