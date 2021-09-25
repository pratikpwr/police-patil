import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:policepatil/src/views/widgets/attach_button.dart';

class DeathScreen extends StatefulWidget {
  const DeathScreen({Key? key}) : super(key: key);

  @override
  _DeathScreenState createState() => _DeathScreenState();
}

class _DeathScreenState extends State<DeathScreen> {
  var _isIdentified;
  String? _gender;
  final List<String> _genderTypes = <String>["पुरुष", "स्त्री", "इतर"];
  Position? _addPos;
  String _addLong = LONGITUDE;
  String _addLat = LATITUDE;

  Position? _placePos;
  String _placeLong = LONGITUDE;
  String _placeLat = LATITUDE;

  File? _photoImage;
  String _photoName = "फोटो जोडा";
  final picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DEATHS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ओळख पटलेली आहे का ?",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: YES,
                                groupValue: _isIdentified,
                                onChanged: (value) {
                                  setState(() {
                                    _isIdentified = value;
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
                                groupValue: _isIdentified,
                                onChanged: (value) {
                                  setState(() {
                                    _isIdentified = value;
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
                _isIdentified == YES
                    ? Column(
                  children: [
                      buildTextField(_nameController, NAME),
                      spacer(),
                      buildDropButton(
                          value: _gender,
                          items: _genderTypes,
                          hint: "लिंग निवडा",
                          onChanged: (String? value) {
                            setState(() {
                              _gender = value;
                            });
                          }),
                      spacer(),
                      buildTextField(_addressController, ADDRESS),
                      spacer(),
                      AttachButton(
                          text: SELECT_LOCATION,
                          icon: Icons.location_on_rounded,
                          onTap: () async {
                            _addPos = await determinePosition();
                            setState(() {
                              _addLong = _addPos!.longitude.toString();
                              _addLat = _addPos!.latitude.toString();
                            });
                          }),
                      spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("$LONGITUDE: $_addLong",
                              style: GoogleFonts.poppins(fontSize: 14)),
                          const SizedBox(width: 12),
                          Text("$LATITUDE: $_addLat",
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
                      buildTextField(_placeController, "कोठे सापडले ठिकाण"),
                      spacer(),
                      buildTextField(_reasonController, "मरणाचे प्राथमिक कारण")
                    ],
                )
                    : spacer(height: 0),
                _isIdentified == NO
                    ? Column(
                  children: [
                      buildTextField(_ageController, "अंदाजे वय"),
                      spacer(),
                      buildDropButton(
                          value: _gender,
                          items: _genderTypes,
                          hint: "लिंग निवडा",
                          onChanged: (String? value) {
                            setState(() {
                              _gender = value;
                            });
                          }),
                      spacer(),
                      AttachButton(
                        text: _photoName,
                        onTap: () {
                          getImage(context, _photoImage);
                        },
                      ),
                      spacer(),
                      buildTextField(_placeController, "कोठे सापडले ठिकाण"),
                      spacer(),
                      AttachButton(
                          text: SELECT_LOCATION,
                          icon: Icons.location_on_rounded,
                          onTap: () async {
                            _placePos = await determinePosition();
                            setState(() {
                              _placeLong = _placePos!.longitude.toString();
                              _placeLat = _placePos!.latitude.toString();
                            });
                          }),
                      spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("$LONGITUDE: $_placeLong",
                              style: GoogleFonts.poppins(fontSize: 14)),
                          const SizedBox(width: 12),
                          Text("$LATITUDE: $_placeLat",
                              style: GoogleFonts.poppins(fontSize: 14)),
                        ],
                      ),
                      spacer(),
                      buildTextField(_reasonController, "मरणाचे प्राथमिक कारण")
                    ],
                )
                    : spacer(height: 0),
                spacer(),
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
          ],
        ),
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
