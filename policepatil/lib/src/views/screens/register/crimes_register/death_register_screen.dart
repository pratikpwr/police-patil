import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:policepatil/src/views/widgets/attach_button.dart';
import 'package:shared/shared.dart';

class DeathRegFormScreen extends StatefulWidget {
  const DeathRegFormScreen({Key? key}) : super(key: key);

  @override
  _DeathRegFormScreenState createState() => _DeathRegFormScreenState();
}

class _DeathRegFormScreenState extends State<DeathRegFormScreen> {
  Position? _addPos;
  final _bloc = DeathRegisterBloc();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

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
                              groupValue: _bloc.isIdentified,
                              onChanged: (value) {
                                setState(() {
                                  _bloc.isIdentified = value;
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
                              groupValue: _bloc.isIdentified,
                              onChanged: (value) {
                                setState(() {
                                  _bloc.isIdentified = value;
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
              _bloc.isIdentified == YES
                  ? Column(
                      children: [
                        buildTextField(_nameController, NAME),
                        spacer(),
                        buildDropButton(
                            value: _bloc.gender,
                            items: _bloc.genderTypes,
                            hint: "लिंग निवडा",
                            onChanged: (String? value) {
                              setState(() {
                                _bloc.gender = value;
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
                                _bloc.longitude = _addPos!.longitude;
                                _bloc.latitude = _addPos!.latitude;
                              });
                            }),
                        spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("$LONGITUDE: ${_bloc.longitude}",
                                style: GoogleFonts.poppins(fontSize: 14)),
                            const SizedBox(width: 12),
                            Text("$LATITUDE: ${_bloc.latitude}",
                                style: GoogleFonts.poppins(fontSize: 14)),
                          ],
                        ),
                        spacer(),
                        AttachButton(
                          text: _bloc.photoName,
                          onTap: () async {
                            getFileFromDevice(context).then((pickedFile) {
                              setState(() {
                                _bloc.photo = pickedFile;
                                _bloc.photoName = getFileName(pickedFile!.path);
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
              _bloc.isIdentified == NO
                  ? Column(
                      children: [
                        buildTextField(_ageController, "अंदाजे वय"),
                        spacer(),
                        buildDropButton(
                            value: _bloc.gender,
                            items: _bloc.genderTypes,
                            hint: "लिंग निवडा",
                            onChanged: (String? value) {
                              setState(() {
                                _bloc.gender = value;
                              });
                            }),
                        spacer(),
                        AttachButton(
                          text: _bloc.photoName,
                          onTap: () async {
                            getFileFromDevice(context).then((pickedFile) {
                              setState(() {
                                _bloc.photo = pickedFile;
                                _bloc.photoName = getFileName(pickedFile!.path);
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
                                _bloc.longitude = _addPos!.longitude;
                                _bloc.latitude = _addPos!.latitude;
                              });
                            }),
                        spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("$LONGITUDE: ${_bloc.longitude}",
                                style: GoogleFonts.poppins(fontSize: 14)),
                            const SizedBox(width: 12),
                            Text("$LATITUDE: ${_bloc.latitude}",
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
              CustomButton(
                  text: DO_REGISTER,
                  onTap: () {
                    _registerDeathData();
                  })
            ],
          ),
        )),
      ),
    );
  }

  _registerDeathData() {
    DateFormat _format = DateFormat("yyyy-MM-dd");
    DeathData _deathData = DeathData(
        isKnown: _bloc.isIdentified == YES,
        name: _nameController.text,
        gender: _bloc.gender,
        address: _addressController.text,
        latitude: _bloc.latitude,
        longitude: _bloc.longitude,
        photo: _bloc.photo?.path,
        foundAddress: _placeController.text,
        causeOfDeath: _reasonController.text,
        dateOfDeath: _format.parse(_dateController.text),
        age: int.parse(_ageController.text));

    BlocProvider.of<DeathRegisterBloc>(context).add(AddDeathData(_deathData));
  }
}
