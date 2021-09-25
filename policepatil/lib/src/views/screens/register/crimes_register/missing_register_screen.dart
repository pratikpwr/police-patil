import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:policepatil/src/views/widgets/attach_button.dart';

class MissingScreen extends StatefulWidget {
  const MissingScreen({Key? key}) : super(key: key);

  @override
  _MissingScreenState createState() => _MissingScreenState();
}

class _MissingScreenState extends State<MissingScreen> {
  var _isAbove18;
  String? _gender;
  final List<String> _genderTypes = <String>["पुरुष", "स्त्री", "इतर"];

  Position? _position;
  String _longitude = LONGITUDE;
  String _latitude = LATITUDE;

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
              onTap: () {
                getImage(context, _fileImage);
              },
            ),
            spacer(),
            AttachButton(
              text: _photoName,
              onTap: () {
                getImage(context, _photoImage);
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
            buildDateTextField(
                context, _dateController, "मिसिंग झाल्याची तारीख"),
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
