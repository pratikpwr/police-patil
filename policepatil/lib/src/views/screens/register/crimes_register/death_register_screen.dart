import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class DeathRegFormScreen extends StatefulWidget {
  DeathRegFormScreen({Key? key, this.deathData}) : super(key: key);
  DeathData? deathData;

  @override
  _DeathRegFormScreenState createState() => _DeathRegFormScreenState();
}

class _DeathRegFormScreenState extends State<DeathRegFormScreen> {
  Position? _addPos;

  var isIdentified;
  String? gender;
  final List<String> genderTypes = <String>["पुरुष", "स्त्री", "इतर"];

  double longitude = 0.00;
  double latitude = 0.00;

  File? photo;
  String photoName = "फोटो जोडा";
  bool _isEdit = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  _initializeValues() {
    /// checks is edit mode or not
    _isEdit = widget.deathData != null;
    isIdentified = _isEdit
        ? widget.deathData!.isKnown!
            ? YES
            : NO
        : null;
    gender = _isEdit ? widget.deathData!.gender : null;
    _nameController.text = _isEdit ? widget.deathData!.name ?? '' : '';
    _ageController.text = "${_isEdit ? widget.deathData!.age ?? '' : ''}";
    _addressController.text = _isEdit ? widget.deathData!.address ?? '' : '';
    _placeController.text = _isEdit ? widget.deathData!.foundAddress ?? '' : '';
    _reasonController.text =
        _isEdit ? widget.deathData!.causeOfDeath ?? '' : '';
    _dateController.text =
        _isEdit ? dateInYYYYMMDDFormat(widget.deathData!.dateOfDeath) : '';
    photoName = _isEdit ? 'फोटो जोडलेले आहे' : 'फोटो जोडा';
    longitude = _isEdit ? widget.deathData!.longitude ?? 0.00 : 0.00;
    latitude = _isEdit ? widget.deathData!.latitude ?? 0.00 : 0.00;
  }

  @override
  Widget build(BuildContext context) {
    _ageController.text = "0";
    return Scaffold(
      appBar: AppBar(
        title: const Text(DEATHS),
      ),
      body: BlocListener<DeathRegisterBloc, DeathRegisterState>(
        listener: (context, state) {
          if (state is DeathDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is DeathDataSent) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
          }
          if (state is DeathDataEdited) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ओळख पटलेली आहे का ?",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: YES,
                              groupValue: isIdentified,
                              onChanged: (value) {
                                setState(() {
                                  isIdentified = value;
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
                              groupValue: isIdentified,
                              onChanged: (value) {
                                setState(() {
                                  isIdentified = value;
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
              isIdentified == YES
                  ? Column(
                      children: [
                        buildTextField(_nameController, NAME),
                        spacer(),
                        buildDropButton(
                            value: gender,
                            items: genderTypes,
                            hint: "लिंग निवडा",
                            onChanged: (String? value) {
                              setState(() {
                                gender = value;
                              });
                            }),
                        spacer(),
                        buildTextField(_addressController, ADDRESS),
                        spacer(),
                        AttachButton(
                            text: SELECT_LOCATION,
                            icon: Icons.location_on_rounded,
                            onTap: () async {
                              _addPos = await determinePosition();
                              setState(() {
                                longitude = _addPos!.longitude;
                                latitude = _addPos!.latitude;
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
                        spacer(),
                        AttachButton(
                          text: photoName,
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
                        buildTextField(_placeController, "कोठे सापडले ठिकाण"),
                        spacer(),
                        buildTextField(
                            _reasonController, "मरणाचे प्राथमिक कारण"),
                        spacer(),
                        buildDateTextField(
                            context, _dateController, "मरणाची तारीख"),
                      ],
                    )
                  : spacer(height: 0),
              isIdentified == NO
                  ? Column(
                      children: [
                        buildTextField(_ageController, "अंदाजे वय"),
                        spacer(),
                        buildDropButton(
                            value: gender,
                            items: genderTypes,
                            hint: "लिंग निवडा",
                            onChanged: (String? value) {
                              setState(() {
                                gender = value;
                              });
                            }),
                        spacer(),
                        AttachButton(
                          text: photoName,
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
                        buildTextField(_placeController, "कोठे सापडले ठिकाण"),
                        spacer(),
                        AttachButton(
                            text: SELECT_LOCATION,
                            icon: Icons.location_on_rounded,
                            onTap: () async {
                              _addPos = await determinePosition();
                              setState(() {
                                longitude = _addPos!.longitude;
                                latitude = _addPos!.latitude;
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
                        spacer(),
                        buildTextField(
                            _reasonController, "मरणाचे प्राथमिक कारण"),
                        spacer(),
                        buildDateTextField(
                            context, _dateController, "मरणाची तारीख"),
                      ],
                    )
                  : spacer(height: 0),
              spacer(),
              BlocBuilder<DeathRegisterBloc, DeathRegisterState>(
                builder: (context, state) {
                  if (state is DeathDataSending) {
                    return const Loading();
                  }
                  return CustomButton(
                      text: DO_REGISTER,
                      onTap: () {
                        _registerDeathData();
                      });
                },
              )
            ],
          ),
        )),
      ),
    );
  }

  _registerDeathData() async {
    DeathData _deathData = DeathData(
        id: _isEdit ? widget.deathData!.id : null,
        isKnown: isIdentified == YES,
        name: _nameController.text,
        gender: gender,
        address: _addressController.text,
        latitude: latitude,
        longitude: longitude,
        photo: photo?.path != null
            ? await MultipartFile.fromFile(photo!.path)
            : null,
        foundAddress: _placeController.text,
        causeOfDeath: _reasonController.text,
        dateOfDeath: parseDate(_dateController.text),
        age: parseInt(_ageController.text));

    _isEdit
        ? BlocProvider.of<DeathRegisterBloc>(context)
            .add(EditDeathData(_deathData))
        : BlocProvider.of<DeathRegisterBloc>(context)
            .add(AddDeathData(_deathData));
  }
}
