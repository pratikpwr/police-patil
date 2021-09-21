// ignore_for_file: prefer_final_fields

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:policepatil/src/views/widgets/attach_button.dart';

class WatchRegScreen extends StatefulWidget {
  const WatchRegScreen({Key? key}) : super(key: key);

  @override
  State<WatchRegScreen> createState() => _WatchRegScreenState();
}

class _WatchRegScreenState extends State<WatchRegScreen> {
  String? _chosenValue;
  Position? _position;
  String _longitude = LONGITUDE;
  String _latitude = LATITUDE;
  final List<String> _watchRegTypes = <String>[
    "भटक्या टोळी",
    "सराईत गुन्हेगार",
    "फरार आरोपी",
    "तडीपार आरोपी",
    "स्टॅंडिंग वॉरंट"
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  String _fileName = 'आधार कार्ड जोडा';
  String _photoName = "फोटो जोडा";
  String _otherPhotoName = "इतर फोटो जोडा";
  File? _otherPhotoImage;
  File? _fileImage;
  File? _photoImage;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          WATCH_REGISTER,
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
                  value: _chosenValue,
                  items: _watchRegTypes,
                  hint: "निगराणी प्रकार निवडा",
                  onChanged: (String? value) {
                    setState(() {
                      _chosenValue = value;
                    });
                  }),
              spacer(),
              buildTextField(_nameController, NAME),
              spacer(),
              buildTextField(_phoneController, MOB_NO),
              spacer(),
              AttachButton(
                text: _photoName,
                onTap: () {
                  getImage(context, _photoImage);
                },
              ),
              spacer(),
              AttachButton(
                text: _fileName,
                onTap: () {
                  getImage(context, _fileImage);
                },
              ),
              spacer(),
              buildTextField(_addressController, ADDRESS),
              // spacer(),
              // GPSWidget(_longitude, _latitude),
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
              TextField(
                controller: _otherController,
                style: GoogleFonts.poppins(fontSize: 14),
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: OTHER_INFO,
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              spacer(),
              AttachButton(
                text: _otherPhotoName,
                onTap: () {
                  getImage(context, _otherPhotoImage);
                },
              ),
              spacer(),
              CustomButton(
                  text: DO_REGISTER,
                  onTap: () {
                    showSnackBar(context, SAVED);
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