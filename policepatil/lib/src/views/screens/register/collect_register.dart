import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';

class CollectRegFormScreen extends StatefulWidget {
  const CollectRegFormScreen({Key? key}) : super(key: key);

  @override
  State<CollectRegFormScreen> createState() => _CollectRegFormScreenState();
}

class _CollectRegFormScreenState extends State<CollectRegFormScreen> {
  String? _chosenValue;

  final List<String> _collectionType = <String>[
    "बेवारस वाहने",
    "दागिने",
    "गौण खनिज",
    "इतर"
  ];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  Position? _position;
  String _longitude = LONGITUDE;
  String _latitude = LATITUDE;

  String _photoName = "फोटो जोडा";
  File? _photoImage;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          COLLECTION_REGISTER,
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
                    items: _collectionType,
                    hint: "जप्ती मालाचा प्रकार निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    }),
                spacer(),
                buildTextField(_addressController, PLACE),
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
                buildDateTextField(context, _dateController, DATE),
                spacer(),
                buildTextField(_detailsController, "जप्ती मालाचे वर्णन"),
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
                          return const RegisterMenuScreen();
                        }));
                      });
                    })
              ],
            )),
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
