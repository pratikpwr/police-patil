import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';

class FiresScreen extends StatefulWidget {
  const FiresScreen({Key? key}) : super(key: key);

  @override
  _FiresScreenState createState() => _FiresScreenState();
}

class _FiresScreenState extends State<FiresScreen> {
  Position? _position;
  String _longitude = LONGITUDE;
  String _latitude = LATITUDE;

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
      body: SafeArea(
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
              onTap: () {
                getImage(context, _photoImage);
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
