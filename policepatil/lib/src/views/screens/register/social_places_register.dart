import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';

import '../../views.dart';

class SocialPlacesRegFormScreen extends StatefulWidget {
  const SocialPlacesRegFormScreen({Key? key}) : super(key: key);

  @override
  State<SocialPlacesRegFormScreen> createState() =>
      _SocialPlacesRegFormScreenState();
}

class _SocialPlacesRegFormScreenState extends State<SocialPlacesRegFormScreen> {
  String? _chosenValue;

  Position? _position;
  String _longitude = LONGITUDE;
  String _latitude = LATITUDE;

  File? _photoImage;
  String _photoName = "फोटो जोडा";
  final picker = ImagePicker();

  final List<String> _socialPlaceTypes = <String>[
    "रस्ता",
    "पाणवठा",
    "जमीन",
    "पुतळा",
    "धार्मिक स्थळ"
  ];

  var _isIssue;
  var _isCCTV;
  var _isCrimeReg;

  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _situationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          SOCIAL_PLACES,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(children: [
              spacer(),
              buildDropButton(
                  value: _chosenValue,
              items: _socialPlaceTypes,
              hint: "सार्वजनिक महत्त्वाचे स्थळ निवडा",
              onChanged: (String? value) {
                setState(() {
                  _chosenValue = value;
                });
              }),
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
                  style: GoogleFonts.poppins(fontSize: 14)),
              const SizedBox(width: 12),
              Text("$LATITUDE: $_latitude",
                  style: GoogleFonts.poppins(fontSize: 14)),
            ],
          ),
          spacer(),
          AttachButton(
            text: _photoName,
            onTap: () {
              getImage(context, _photoImage);
            },
          ),
          spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "सीसीटीव्ही बसवला आहे का ?",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              Row(
                children: [
                  Row(
                        children: [
                          Radio(
                              value: YES,
                              groupValue: _isCCTV,
                              onChanged: (value) {
                                setState(() {
                                  _isCCTV = value;
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
                              groupValue: _isCCTV,
                              onChanged: (value) {
                                setState(() {
                                  _isCCTV = value;
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
              _isIssue == YES
                  ? Column(
                children: [
                  buildTextField(_reasonController, "वादाचे कारण"),
                  spacer(),
                  buildTextField(_situationController, "वादाची सद्यस्थिती"),
                  spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "गुन्हा दाखल आहे का ?",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                  value: YES,
                                  groupValue: _isCrimeReg,
                                  onChanged: (value) {
                                    setState(() {
                                      _isCrimeReg = value;
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
                                  groupValue: _isCrimeReg,
                                  onChanged: (value) {
                                    setState(() {
                                      _isCrimeReg = value;
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
                ],
              )
                  : spacer(height: 0),
              CustomButton(
                  text: DO_REGISTER,
                  onTap: () {
                    showSnackBar(context, SAVED);
                    Future.delayed(const Duration(seconds: 1)).then((_) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) {
                        return const RegisterMenuScreen();
                  }));
                });
              })
        ]),
      )),
    );
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
