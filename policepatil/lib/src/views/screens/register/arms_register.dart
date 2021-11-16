// ignore_forfile: prefer_final_fields

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

/// The forms screen handles adding and editing data
/// editing the data has made this so much complex
class ArmsRegFormScreen extends StatefulWidget {
  ArmsRegFormScreen({Key? key, this.armsData}) : super(key: key);
  ArmsData? armsData; // if mode is editing this is required

  @override
  State<ArmsRegFormScreen> createState() => _ArmsRegFormScreenState();
}

class _ArmsRegFormScreenState extends State<ArmsRegFormScreen> {
  bool _isEdit = false;
  Position? _position;
  double longitude = 0.00;
  double latitude = 0.00;

  String? armsValue;
  String? weaponCondition;

  final List<String> weaponCondTypes = <String>[
    "परवाना धारकाकडे शस्त्र आहे",
    "पो. ठा. कडे जमा",
    "गहाळ",
    "फक्त परवाना आहे शस्त्र नाही",
  ];
  final List<String> armsRegTypes = <String>[
    "शस्त्र परवानाधारक",
    "स्फोटक पदार्थ विक्री",
    "स्फोटक जवळ बाळगणारे",
    "स्फोटक उडविणारे"
  ];

  String? fileName;
  String? photoName;

  File? file;
  File? photo;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _certificateNoController =
      TextEditingController();
  final TextEditingController _uIDController = TextEditingController();
  final TextEditingController _certificateExpiryController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  _initializeValues() {
    /// checks is edit mode or not
    _isEdit = widget.armsData != null;

    /// based on mode if its edit then previous values assigned
    _nameController.text = _isEdit ? widget.armsData!.name ?? '' : '';
    _phoneController.text = "${_isEdit ? widget.armsData!.mobile ?? '' : ''}";
    _addressController.text = _isEdit ? widget.armsData!.address ?? '' : '';
    _certificateNoController.text =
        _isEdit ? widget.armsData!.licenceNumber ?? '' : '';
    _uIDController.text = _isEdit ? widget.armsData!.uid ?? '' : '';
    _certificateExpiryController.text =
        _isEdit ? dateInYYYYMMDDFormat(widget.armsData!.validity) : '';
    armsValue = _isEdit ? widget.armsData!.type : null;
    weaponCondition = _isEdit ? widget.armsData!.weaponCondition : null;
    fileName = _isEdit ? 'आधार कार्ड जोडलेले आहे' : 'आधार कार्ड जोडा';
    photoName =
        _isEdit ? 'परवान्याचा फोटो जोडलेले आहे' : 'परवान्याचा फोटो जोडा';
    longitude = _isEdit ? widget.armsData!.longitude ?? 0.00 : 0.00;
    latitude = _isEdit ? widget.armsData!.latitude ?? 0.00 : 0.00;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ARMS_COLLECTIONS),
      ),
      body: BlocListener<ArmsRegisterBloc, ArmsRegisterState>(
          listener: (context, state) {
            if (state is ArmsDataSendError) {
              showSnackBar(context, SOMETHING_WENT_WRONG);
            }
            if (state is ArmsDataSent) {
              // showSnackBar(context, state.message);
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
                        value: armsValue,
                        items: armsRegTypes,
                        hint: "प्रकार निवडा",
                        onChanged: (String? value) {
                          setState(() {
                            armsValue = value;
                          });
                        }),
                    spacer(),
                    buildTextField(_nameController, NAME),
                    spacer(),
                    buildTextField(_phoneController, MOB_NO),
                    spacer(),
                    AttachButton(
                      text: fileName!,
                      onTap: () async {
                        getFileFromDevice(context).then((pickedFile) {
                          setState(() {
                            file = pickedFile;
                            fileName = getFileName(pickedFile!.path);
                          });
                        });
                      },
                    ),
                    spacer(),
                    buildTextField(_addressController, ADDRESS),
                    spacer(),
                    if (armsValue != "शस्त्र परवानाधारक")
                      Column(
                        children: [
                          AttachButton(
                              text: SELECT_LOCATION,
                              icon: Icons.location_on_rounded,
                              onTap: () async {
                                _position = await determinePosition();
                                setState(() {
                                  longitude = _position!.longitude;
                                  latitude = _position!.latitude;
                                });
                              }),
                          spacer(),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("$LONGITUDE: $longitude",
                                  style: GoogleFonts.poppins(fontSize: 14)),
                              const SizedBox(width: 12),
                              Text("$LATITUDE: $latitude",
                                  style: GoogleFonts.poppins(fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    spacer(height: 8),
                    if (armsValue == "शस्त्र परवानाधारक")
                      buildTextField(_uIDController, "युआईडी क्रमांक"),
                    spacer(),
                    buildTextField(_certificateNoController, "परवाना क्रमांक"),
                    spacer(),
                    buildDateTextField(context, _certificateExpiryController,
                        "परवान्याची वैधता कालावधी"),
                    spacer(),
                    if (armsValue == "शस्त्र परवानाधारक")
                      buildDropButton(
                          value: weaponCondition,
                          items: weaponCondTypes,
                          hint: "शस्त्राची सद्यस्तिथी निवडा",
                          onChanged: (String? value) {
                            setState(() {
                              weaponCondition = value;
                            });
                          }),
                    spacer(),
                    AttachButton(
                      text: photoName!,
                      onTap: () async {
                        getFileFromDevice(context).then((pickedFile) {
                          setState(() {
                            photo = pickedFile;
                            photoName = getFileName(pickedFile!.path);
                          });
                        });
                      },
                    ),
                    spacer(),
                    BlocBuilder<ArmsRegisterBloc, ArmsRegisterState>(
                      builder: (context, state) {
                        if (state is ArmsDataSending) {
                          return const Loading();
                        }
                        return CustomButton(
                            text: DO_REGISTER,
                            onTap: () {
                              _registerArmsData();
                            });
                      },
                    ),
                    spacer()
                  ],
                )),
          )),
    );
  }

  _registerArmsData() async {
    ArmsData armsData = ArmsData(
        id: _isEdit ? widget.armsData!.id : null,
        type: armsValue ?? widget.armsData!.type,
        name: _nameController.text,
        mobile: parseInt(_phoneController.text),
        aadhar: file?.path != null
            ? await MultipartFile.fromFile(file!.path)
            : null,
        uid: _uIDController.text,
        weaponCondition: weaponCondition,
        address: _addressController.text,
        latitude: latitude,
        longitude: longitude,
        validity: _isEdit
            ? widget.armsData!.validity
            : parseDate(_certificateExpiryController.text),
        licencephoto: photo?.path != null
            ? await MultipartFile.fromFile(photo!.path)
            : null,
        licenceNumber: _certificateNoController.text);

    BlocProvider.of<ArmsRegisterBloc>(context)
        .add(_isEdit ? EditArmsData(armsData) : AddArmsData(armsData));
  }
}
