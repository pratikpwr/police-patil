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
import 'package:shared/shared.dart';

class FireRegFormScreen extends StatefulWidget {
  const FireRegFormScreen({Key? key}) : super(key: key);

  @override
  _FireRegFormScreenState createState() => _FireRegFormScreenState();
}

class _FireRegFormScreenState extends State<FireRegFormScreen> {
  Position? _position;
  double _longitude = 0.00;
  double _latitude = 0.00;

  File? _photoImage;
  String _photoName = "फोटो जोडा";
  final picker = ImagePicker();

  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _lossController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          BURNS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<FireRegisterBloc, FireRegisterState>(
        listener: (context, state) {
          if (state is FireDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is FireDataSent) {
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
              buildTextField(_placeController, "घटनास्थळ"),
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
                  Text("$LATITUDE: $_latitude",
                      style: GoogleFonts.poppins(fontSize: 14)),
                ],
              ),
              spacer(),
              buildDateTextField(context, _dateController, DATE),
              spacer(),
              buildTimeTextField(context, _timeController, TIME),
              spacer(),
              buildTextField(_reasonController, "आगीचे कारण"),
              spacer(),
              buildTextField(_lossController, "अंदाजे झालेले नुकसान"),
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
              CustomButton(
                  text: DO_REGISTER,
                  onTap: () {
                    _registerFireData();
                  }),
              spacer()
            ],
          ),
        )),
      ),
    );
  }

  _registerFireData() {
    DateFormat _format = DateFormat("yyyy-MM-dd");
    FireData _fireData = FireData(
        address: _placeController.text,
        latitude: _latitude,
        longitude: _longitude,
        date: _format.parse(_dateController.text),
        time: _timeController.text,
        reason: _reasonController.text,
        loss: _lossController.text,
        photo: _photoImage?.path);

    BlocProvider.of<FireRegisterBloc>(context).add(AddFireData(_fireData));
  }
}
