// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class ArmsRegFormScreen extends StatefulWidget {
  const ArmsRegFormScreen({Key? key}) : super(key: key);

  @override
  State<ArmsRegFormScreen> createState() => _ArmsRegFormScreenState();
}

class _ArmsRegFormScreenState extends State<ArmsRegFormScreen> {
  String? _chosenValue;
  String? _weaponCondition;
  final List<String> _weaponCondTypes = <String>[
    "परवाना धारकाकडे शस्त्र आहे",
    "पो. ठा. कडे जमा",
    "गहाळ",
    "फक्त परवाना आहे शस्त्र नाही",
  ];
  final List<String> _armsRegTypes = <String>[
    "शस्त्र परवानाधारक",
    "स्फोटक पदार्थ विक्री",
    "स्फोटक जवळ बाळगणारे",
    "स्फोटक उडविणारे"
  ];

  Position? _position;
  double _longitude = 0.00;
  double _latitude = 0.00;

  String _fileName = 'आधार कार्ड जोडा';
  String _photoName = "परवान्याचा फोटो जोडा";
  File? _file;
  File? _photo;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _certificateNoController =
      TextEditingController();
  final TextEditingController _uIDController = TextEditingController();
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
              showSnackBar(context, state.error);
            }
            if (state is ArmsDataSent) {
              showSnackBar(context, state.message);
              Navigator.pop(context);
            }
          },
          child: SafeArea(
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
                          });
                        }),
                    spacer(),
                    buildTextField(_nameController, NAME),
                    spacer(),
                    buildTextField(_phoneController, MOB_NO),
                    spacer(),
                    AttachButton(
                      text: _fileName,
                      onTap: () async {
                        getFileFromDevice(context).then((pickedFile) {
                          setState(() {
                            _file = pickedFile;
                            _fileName = getFileName(pickedFile!.path);
                          });
                        });
                      },
                    ),
                    spacer(),
                    buildTextField(_addressController, ADDRESS),
                    spacer(),
                    if (_chosenValue != "शस्त्र परवानाधारक")
                      Column(
                        children: [
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
                        ],
                      ),
                    spacer(),
                    if (_chosenValue == "शस्त्र परवानाधारक")
                      buildTextField(_uIDController, "युआईडी क्रमांक"),
                    spacer(),
                    buildTextField(_certificateNoController, "परवाना क्रमांक"),
                    spacer(),
                    buildDateTextField(context, _certificateExpiryController,
                        "परवान्याची वैधता कालावधी"),
                    spacer(),
                    if (_chosenValue == "शस्त्र परवानाधारक")
                      buildDropButton(
                          value: _weaponCondition,
                          items: _weaponCondTypes,
                          hint: "शस्त्राची सद्यस्तिथी निवडा",
                          onChanged: (String? value) {
                            setState(() {
                              _weaponCondition = value;
                            });
                          }),
                    spacer(),
                    AttachButton(
                      text: _photoName,
                      onTap: () async {
                        getFileFromDevice(context).then((pickedFile) {
                          setState(() {
                            _photo = pickedFile;
                            _photoName = getFileName(pickedFile!.path);
                          });
                        });
                      },
                    ),
                    spacer(),
                    CustomButton(
                        text: DO_REGISTER,
                        onTap: () {
                          _registerArmsData();
                        }),
                    spacer()
                  ],
                )),
          )),
    );
  }

  _registerArmsData() {
    DateFormat format = DateFormat("yyyy-MM-dd");
    // TODO : add uid field and weapon condition dropdown
    ArmsData armsData = ArmsData(
        type: _chosenValue!,
        name: _nameController.text,
        mobile: int.parse(_phoneController.text),
        aadhar: _file?.path,
        address: _addressController.text,
        latitude: _latitude,
        longitude: _longitude,
        validity: format.parse(_certificateExpiryController.text),
        licencephoto: _photo?.path,
        licenceNumber: _certificateNoController.text);

    BlocProvider.of<ArmsRegisterBloc>(context).add(AddArmsData(armsData));
  }
}
