import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:policepatil/src/views/widgets/attach_button.dart';
import 'package:shared/shared.dart';

class MissingRegFormScreen extends StatefulWidget {
  const MissingRegFormScreen({Key? key}) : super(key: key);

  @override
  _MissingRegFormScreenState createState() => _MissingRegFormScreenState();
}

class _MissingRegFormScreenState extends State<MissingRegFormScreen> {
  var _isAbove18;
  String? _gender;
  final List<String> _genderTypes = <String>["पुरुष", "स्त्री", "इतर"];

  Position? _position;
  double _longitude = 0.00;
  double _latitude = 0.00;

  File? _photoImage;
  String _photoName = "फोटो जोडा";
  File? _fileImage;
  String _fileName = 'आधार कार्ड जोडा';
  final picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MISSING,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<MissingRegisterBloc, MissingRegisterState>(
        listener: (context, state) {
          if (state is MissingDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is MissingDataSent) {
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
                    "१८ वर्षावरील आहे का ?",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: YES,
                              groupValue: _isAbove18,
                              onChanged: (value) {
                                setState(() {
                                  _isAbove18 = value;
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
                              groupValue: _isAbove18,
                              onChanged: (value) {
                                setState(() {
                                  _isAbove18 = value;
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
              buildTextField(_nameController, NAME),
              spacer(),
              buildTextField(_ageController, AGE),
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
                text: _fileName,
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
                                  final pickedImage = await picker.pickImage(
                                      source: ImageSource.camera);
                                  setState(() {
                                    if (pickedImage != null) {
                                      _fileName = pickedImage.name;
                                      _fileImage = File(pickedImage.path);
                                    } else {
                                      debugPrint('No image selected.');
                                    }
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'कॅमेरा',
                                  style: GoogleFonts.poppins(fontSize: 14),
                                )),
                            TextButton(
                                onPressed: () async {
                                  final pickedImage = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {
                                    if (pickedImage != null) {
                                      _fileName = pickedImage.name;
                                      _fileImage = File(pickedImage.path);
                                    } else {
                                      debugPrint('No image selected.');
                                    }
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'गॅलरी',
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ))
                          ],
                        );
                      });
                },
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
                                  final pickedImage = await picker.pickImage(
                                      source: ImageSource.camera);
                                  setState(() {
                                    if (pickedImage != null) {
                                      _photoName = pickedImage.name;
                                      _photoImage = File(pickedImage.path);
                                    } else {
                                      debugPrint('No image selected.');
                                    }
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'कॅमेरा',
                                  style: GoogleFonts.poppins(fontSize: 14),
                                )),
                            TextButton(
                                onPressed: () async {
                                  final pickedImage = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {
                                    if (pickedImage != null) {
                                      _photoName = pickedImage.name;
                                      _photoImage = File(pickedImage.path);
                                    } else {
                                      debugPrint('No image selected.');
                                    }
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'गॅलरी',
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ))
                          ],
                        );
                      });
                },
              ),
              spacer(),
              buildTextField(_addressController, ADDRESS),
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
              buildDateTextField(
                  context, _dateController, "मिसिंग झाल्याची तारीख"),
              spacer(),
              CustomButton(
                  text: DO_REGISTER,
                  onTap: () {
                    _registerMissingData();
                  })
            ],
          ),
        )),
      ),
    );
  }

  _registerMissingData() {
    DateFormat _format = DateFormat("yyyy-MM-dd");

    MissingData _missingData = MissingData(
        isAdult: _isAbove18 == YES,
        name: _nameController.text,
        age: int.parse(_ageController.text),
        gender: _gender,
        aadhar: _fileImage?.path,
        photo: _photoImage?.path,
        address: _addressController.text,
        latitude: _latitude,
        longitude: _longitude,
        missingDate: _format.parse(_dateController.text));

    BlocProvider.of<MissingRegisterBloc>(context)
        .add(AddMissingData(_missingData));
  }
}
