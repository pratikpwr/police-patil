// ignore_for_file: prefer_final_fields

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
import 'package:shared/modules/watch_register/bloc/watch_register_bloc.dart';
import 'package:shared/shared.dart';

class WatchRegFormScreen extends StatefulWidget {
  const WatchRegFormScreen({Key? key}) : super(key: key);

  @override
  State<WatchRegFormScreen> createState() => _WatchRegFormScreenState();
}

class _WatchRegFormScreenState extends State<WatchRegFormScreen> {
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
      body: BlocListener<WatchRegisterBloc, WatchRegisterState>(
        listener: (context, state) {
          if (state is WatchDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is WatchDataSent) {
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
                        style: GoogleFonts.poppins(fontSize: 14)),
                    const SizedBox(width: 12),
                    Text("$LATITUDE: $_latitude",
                        style: GoogleFonts.poppins(fontSize: 14)),
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
                                        _otherPhotoName = pickedImage.name;
                                        _otherPhotoImage =
                                            File(pickedImage.path);
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
                                        _otherPhotoName = pickedImage.name;
                                        _otherPhotoImage =
                                            File(pickedImage.path);
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
                CustomButton(
                    text: DO_REGISTER,
                    onTap: () {
                      _registerWatchData();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  _registerWatchData() {
    WatchData _watchData = WatchData(
        type: _chosenValue,
        name: _nameController.text,
        mobile: int.parse(_phoneController.text),
        photo: _photoImage?.path,
        aadhar: _fileImage?.path,
        address: _addressController.text,
        latitude: double.parse(_latitude),
        longitude: double.parse(_longitude),
        description: _otherController.text,
        otherPhoto: _otherPhotoImage?.path);

    BlocProvider.of<WatchRegisterBloc>(context).add(AddWatchData(_watchData));
  }
}
