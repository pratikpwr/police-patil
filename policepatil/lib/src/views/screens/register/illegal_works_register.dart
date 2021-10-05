import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/shared.dart';
import '../../views.dart';

class IllegalWorksFormScreen extends StatefulWidget {
  const IllegalWorksFormScreen({Key? key}) : super(key: key);

  @override
  State<IllegalWorksFormScreen> createState() => _IllegalWorksFormScreenState();
}

class _IllegalWorksFormScreenState extends State<IllegalWorksFormScreen> {
  String? _chosenValue;

  Position? _position;
  String _longitude = LONGITUDE;
  String _latitude = LATITUDE;

  File? _photoImage;
  String _photoName = "फोटो जोडा";
  final picker = ImagePicker();

  final List<String> _watchRegTypes = <String>[
    "अवैद्य दारू विक्री करणारे",
    "अवैद्य गुटका विक्री करणारे",
    "जुगार/मटका चालविणारे/खेळणारे",
    "अवैद्य गौण खनिज उत्खनन करणारे वाळू तस्कर",
    "अमली पदार्थ विक्री करणारे"
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _vehicleNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ILLEGAL_WORKS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<IllegalRegisterBloc, IllegalRegisterState>(
          listener: (context, state) {
            if (state is IllegalDataSendError) {
              showSnackBar(context, state.error);
            }
            if (state is IllegalDataSent) {
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
                        hint: "अवैद्य धंदे प्रकार निवडा",
                        onChanged: (String? value) {
                          setState(() {
                            _chosenValue = value;
                          });
                        }),
                    spacer(),
                    buildTextField(_nameController, NAME),
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
                    _chosenValue == _watchRegTypes[3] ||
                            _chosenValue == _watchRegTypes[4]
                        ? buildTextField(_vehicleNoController, VEHICLE_NO)
                        : spacer(height: 0),
                    spacer(),
                    CustomButton(
                        text: DO_REGISTER,
                        onTap: () {
                          _registerIllegalData();
                        })
                  ],
                )),
          )),
    );
  }

  _registerIllegalData() {
    IllegalData _illegalData = IllegalData(
      type: _chosenValue,
      name: _nameController.text,
      photo: "sjhdfs",
      address: _addressController.text,
      latitude: double.parse(_latitude),
      longitude: double.parse(_longitude),
    );

    BlocProvider.of<IllegalRegisterBloc>(context)
        .add(AddIllegalData(_illegalData));
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
