// ignore_for_bloc.file: prefer_final_fields

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
  final _bloc = ArmsRegisterBloc();

  Position? _position;

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
        title: const Text(ARMS_COLLECTIONS),
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
                        value: _bloc.armsValue,
                        items: _bloc.armsRegTypes,
                        hint: "प्रकार निवडा",
                        onChanged: (String? value) {
                          setState(() {
                            _bloc.armsValue = value;
                          });
                        }),
                    spacer(),
                    buildTextField(_nameController, NAME),
                    spacer(),
                    buildTextField(_phoneController, MOB_NO),
                    spacer(),
                    AttachButton(
                      text: _bloc.fileName,
                      onTap: () async {
                        getFileFromDevice(context).then((pickedFile) {
                          setState(() {
                            _bloc.file = pickedFile;
                            _bloc.fileName = getFileName(pickedFile!.path);
                          });
                        });
                      },
                    ),
                    spacer(),
                    buildTextField(_addressController, ADDRESS),
                    spacer(),
                    if (_bloc.armsValue != "शस्त्र परवानाधारक")
                      Column(
                        children: [
                          AttachButton(
                              text: SELECT_LOCATION,
                              icon: Icons.location_on_rounded,
                              onTap: () async {
                                _position = await determinePosition();
                                setState(() {
                                  _bloc.longitude = _position!.longitude;
                                  _bloc.latitude = _position!.latitude;
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
                        ],
                      ),
                    spacer(height: 8),
                    if (_bloc.armsValue == "शस्त्र परवानाधारक")
                      buildTextField(_uIDController, "युआईडी क्रमांक"),
                    spacer(),
                    buildTextField(_certificateNoController, "परवाना क्रमांक"),
                    spacer(),
                    buildDateTextField(context, _certificateExpiryController,
                        "परवान्याची वैधता कालावधी"),
                    spacer(),
                    if (_bloc.armsValue == "शस्त्र परवानाधारक")
                      buildDropButton(
                          value: _bloc.weaponCondition,
                          items: _bloc.weaponCondTypes,
                          hint: "शस्त्राची सद्यस्तिथी निवडा",
                          onChanged: (String? value) {
                            setState(() {
                              _bloc.weaponCondition = value;
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
    ArmsData armsData = ArmsData(
        type: _bloc.armsValue!,
        name: _nameController.text,
        mobile: int.parse(_phoneController.text),
        aadhar: _bloc.file?.path,
        uid: _uIDController.text,
        weaponCondition: _bloc.weaponCondition,
        address: _addressController.text,
        latitude: _bloc.latitude,
        longitude: _bloc.longitude,
        validity: format.parse(_certificateExpiryController.text),
        licencephoto: _bloc.photo?.path,
        licenceNumber: _certificateNoController.text);

    BlocProvider.of<ArmsRegisterBloc>(context).add(AddArmsData(armsData));
  }
}
