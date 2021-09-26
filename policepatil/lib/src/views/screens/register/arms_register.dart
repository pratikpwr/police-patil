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
import 'package:shared/shared.dart';

class ArmsRegFormScreen extends StatefulWidget {
  const ArmsRegFormScreen({Key? key}) : super(key: key);

  @override
  State<ArmsRegFormScreen> createState() => _ArmsRegFormScreenState();
}

class _ArmsRegFormScreenState extends State<ArmsRegFormScreen> {
  String? _chosenValue;
  ArmsData? armsData;
  final List<String> _armsRegTypes = <String>[
    "शस्त्र परवानाधारक",
    "स्फोटक पदार्थ विक्री",
    "स्फोटक जवळ बाळगणारे",
    "स्फोटक उडविणारे"
  ];

  Position? _position;
  String _longitude = LONGITUDE;
  String _latitude = LATITUDE;

  String _fileName = 'आधार कार्ड जोडा';
  String _photoName = "परवान्याचा फोटो जोडा";
  File? _fileImage;
  File? _photoImage;
  final picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _certificateNoController =
  TextEditingController();
  final TextEditingController _certificateExpiryController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ARMS_COLLECTIONS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<ArmsRegisterBloc, ArmsRegisterState>(
        listener: (context, state) {
          if (state is ArmsDataSendError) {
            showSnackBar(context, state.message);
          }
          if (state is ArmsDataSent) {
            showSnackBar(context, "Success");
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<ArmsRegisterBloc, ArmsRegisterState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      spacer(),
                      buildDropButton(
                          value: _chosenValue,
                          items: _armsRegTypes,
                          hint: "प्रकार निवडा",
                          onChanged: (String? value) {
                            setState(() {
                              _chosenValue = value;
                              armsData!.type = value!;
                            });
                          }),
                      spacer(),
                      buildTextField(_nameController, NAME),
                      spacer(),
                      buildTextField(_phoneController, MOB_NO),
                      spacer(),
                      AttachButton(
                        text: _fileName,
                        onTap: () {
                          getImage(context, _fileImage);
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
                      buildTextField(
                          _certificateNoController, "परवाना क्रमांक"),
                      spacer(),
                      buildDateTextField(context, _certificateExpiryController,
                          "परवान्याची वैधता कालावधी"),
                      spacer(),
                      AttachButton(
                        text: _photoName,
                        onTap: () {
                          getImage(context, _photoImage);
                        },
                      ),
                      spacer(),
                      BlocBuilder<ArmsRegisterBloc, ArmsRegisterState>(
                        builder: (context, state) {
                          if (state is ArmsDataSending) {
                            return loading();
                          } else {
                            return CustomButton(
                                text: DO_REGISTER, onTap: _registerArmsData());
                          }
                        },
                      )
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }

  _registerArmsData() {
    armsData!.type = _chosenValue!;
    armsData!.name = _nameController.text;
    armsData!.mobile = int.parse(_phoneController.text);
    armsData!.aadhar = "add aadhar logic";
    armsData!.address = _addressController.text;
    armsData!.latitude = double.parse(_latitude);
    armsData!.longitude = double.parse(_longitude);
    armsData!.licenceNumber = _certificateNoController.text;
    armsData!.validity = DateTime.parse(_certificateExpiryController.text);
    armsData!.licencephoto = "add licence photo";

    BlocProvider.of<ArmsRegisterBloc>(context).add(AddArmsData(armsData!));
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
