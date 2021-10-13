import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:policepatil/src/views/widgets/attach_button.dart';
import 'package:shared/shared.dart';

class DeathRegFormScreen extends StatefulWidget {
  const DeathRegFormScreen({Key? key}) : super(key: key);

  @override
  _DeathRegFormScreenState createState() => _DeathRegFormScreenState();
}

class _DeathRegFormScreenState extends State<DeathRegFormScreen> {
  var _isIdentified;
  String? _gender;
  final List<String> _genderTypes = <String>["पुरुष", "स्त्री", "इतर"];
  Position? _addPos;
  double _longitude = 0.00;
  double _latitude = 0.00;

  File? _photoImage;
  String _photoName = "फोटो जोडा";
  final picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _ageController.text = "0";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DEATHS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<DeathRegisterBloc, DeathRegisterState>(
        listener: (context, state) {
          if (state is DeathDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is DeathDataSent) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
          }
        },
        child: SafeArea(
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
                                _longitude = _addPos!.longitude;
                                _latitude = _addPos!.latitude;
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
                          onTap: () async {
                            await showDialog(
                                context: context,
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
                                                await picker.pickImage(
                                                    source: ImageSource.camera);
                                            setState(() {
                                              if (pickedImage != null) {
                                                _photoName = pickedImage.name;
                                                _photoImage =
                                                    File(pickedImage.path);
                                              } else {
                                                debugPrint(
                                                    'No image selected.');
                                              }
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'कॅमेरा',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            final pickedImage =
                                                await picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            setState(() {
                                              if (pickedImage != null) {
                                                _photoName = pickedImage.name;
                                                _photoImage =
                                                    File(pickedImage.path);
                                              } else {
                                                debugPrint(
                                                    'No image selected.');
                                              }
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'गॅलरी',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14),
                                          ))
                                    ],
                                  );
                                });
                          },
                        ),
                        spacer(),
                        buildTextField(_placeController, "कोठे सापडले ठिकाण"),
                        spacer(),
                        buildTextField(
                            _reasonController, "मरणाचे प्राथमिक कारण"),
                        spacer(),
                        buildDateTextField(
                            context, _dateController, "मरणाची तारीख"),
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
                          onTap: () async {
                            await showDialog(
                                context: context,
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
                                                await picker.pickImage(
                                                    source: ImageSource.camera);
                                            setState(() {
                                              if (pickedImage != null) {
                                                _photoName = pickedImage.name;
                                                _photoImage =
                                                    File(pickedImage.path);
                                              } else {
                                                debugPrint(
                                                    'No image selected.');
                                              }
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'कॅमेरा',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            final pickedImage =
                                                await picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            setState(() {
                                              if (pickedImage != null) {
                                                _photoName = pickedImage.name;
                                                _photoImage =
                                                    File(pickedImage.path);
                                              } else {
                                                debugPrint(
                                                    'No image selected.');
                                              }
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'गॅलरी',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14),
                                          ))
                                    ],
                                  );
                                });
                          },
                        ),
                        spacer(),
                        buildTextField(_placeController, "कोठे सापडले ठिकाण"),
                        spacer(),
                        AttachButton(
                            text: SELECT_LOCATION,
                            icon: Icons.location_on_rounded,
                            onTap: () async {
                              _addPos = await determinePosition();
                              setState(() {
                                _longitude = _addPos!.longitude;
                                _latitude = _addPos!.latitude;
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
                        buildTextField(
                            _reasonController, "मरणाचे प्राथमिक कारण"),
                        spacer(),
                        buildDateTextField(
                            context, _dateController, "मरणाची तारीख"),
                      ],
                    )
                  : spacer(height: 0),
              spacer(),
              CustomButton(
                  text: DO_REGISTER,
                  onTap: () {
                    _registerDeathData();
                  })
            ],
          ),
        )),
      ),
    );
  }

  _registerDeathData() {
    // DateFormat _format = DateFormat("yyyy-MM-dd");
    // ToDo : add death date  to db
    DeathData _deathData = DeathData(
        isKnown: _isIdentified == YES,
        name: _nameController.text,
        gender: _gender,
        address: _addressController.text,
        latitude: _latitude,
        longitude: _longitude,
        photo: _photoImage?.path,
        foundAddress: _placeController.text,
        causeOfDeath: _reasonController.text,
        age: int.parse(_ageController.text));

    BlocProvider.of<DeathRegisterBloc>(context).add(AddDeathData(_deathData));
  }
}
