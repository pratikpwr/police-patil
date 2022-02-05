import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:shared/shared.dart';
import '../../views.dart';

class IllegalWorksFormScreen extends StatefulWidget {
  IllegalWorksFormScreen({Key? key, this.illegalData}) : super(key: key);
  IllegalData? illegalData;

  @override
  State<IllegalWorksFormScreen> createState() => _IllegalWorksFormScreenState();
}

class _IllegalWorksFormScreenState extends State<IllegalWorksFormScreen> {
  bool _isEdit = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _vehicleNoController = TextEditingController();

  Position? _position;

  String? chosenValue;

  double longitude = 0.00;
  double latitude = 0.00;

  File? photo;
  String photoName = "फोटो जोडा";

  final List<String> illegalRegTypes = <String>[
    "अवैद्य दारू विक्री करणारे",
    "अवैद्य गुटका विक्री करणारे",
    "जुगार/मटका चालविणारे/खेळणारे",
    "अवैद्य गौण खनिज उत्खनन करणारे वाळू तस्कर",
    "अमली पदार्थ विक्री करणारे"
  ];

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  _initializeValues() {
    /// checks is edit mode or not
    _isEdit = widget.illegalData != null;

    /// based on mode if its edit then previous values assigned
    _nameController.text = _isEdit ? widget.illegalData!.name ?? '' : '';
    _addressController.text = _isEdit ? widget.illegalData!.address ?? '' : '';
    chosenValue = _isEdit ? widget.illegalData!.type : null;
    photoName = _isEdit ? 'फोटो जोडलेले आहे' : 'फोटो जोडा';
    longitude = _isEdit ? widget.illegalData!.longitude ?? 0.00 : 0.00;
    latitude = _isEdit ? widget.illegalData!.latitude ?? 0.00 : 0.00;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ILLEGAL_WORKS),
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
            if (state is IllegalDataEdited) {
              showSnackBar(context, state.message);
              Navigator.pop(context);
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
                        value: chosenValue,
                        items: illegalRegTypes,
                        hint: "अवैद्य धंदे प्रकार निवडा",
                        onChanged: (String? value) {
                          setState(() {
                            chosenValue = value;
                          });
                        }),
                    spacer(),
                    buildTextField(_nameController, NAME),
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
                    buildTextField(_addressController, ADDRESS),
                    spacer(),
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
                    spacer(),
                    chosenValue == illegalRegTypes[3] ||
                            chosenValue == illegalRegTypes[4]
                        ? buildTextField(_vehicleNoController, VEHICLE_NO)
                        : spacer(height: 0),
                    spacer(),
                    BlocBuilder<IllegalRegisterBloc, IllegalRegisterState>(
                      builder: (context, state) {
                        if (state is IllegalDataSending) {
                          return const Loading();
                        }
                        return CustomButton(
                            text: DO_REGISTER,
                            onTap: () {
                              _registerIllegalData();
                            });
                      },
                    )
                  ],
                )),
          )),
    );
  }

  _registerIllegalData() async {
    IllegalData _illegalData = IllegalData(
      id: _isEdit ? widget.illegalData?.id : null,
      type: chosenValue,
      name: _nameController.text,
      photo: photo?.path != null
          ? await MultipartFile.fromFile(photo!.path)
          : null,
      vehicleNo: _vehicleNoController.text,
      address: _addressController.text,
      latitude: latitude,
      longitude: longitude,
    );

    _isEdit
        ? BlocProvider.of<IllegalRegisterBloc>(context)
            .add(EditIllegalData(_illegalData))
        : BlocProvider.of<IllegalRegisterBloc>(context)
            .add(AddIllegalData(_illegalData));
  }
}
