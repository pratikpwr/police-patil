import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class MissingRegFormScreen extends StatefulWidget {
  MissingRegFormScreen({Key? key, this.missingData}) : super(key: key);
  MissingData? missingData;

  @override
  _MissingRegFormScreenState createState() => _MissingRegFormScreenState();
}

class _MissingRegFormScreenState extends State<MissingRegFormScreen> {
  Position? _position;

  var isAbove18;
  String? gender;
  final List<String> genderTypes = <String>["पुरुष", "स्त्री", "इतर"];

  double longitude = 0.00;
  double latitude = 0.00;

  File? photo;
  String photoName = "फोटो जोडा";
  bool _isEdit = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  _initializeValues() {
    /// checks is edit mode or not
    _isEdit = widget.missingData != null;
    isAbove18 = _isEdit
        ? widget.missingData!.isAdult!
            ? YES
            : NO
        : null;
    gender = _isEdit ? widget.missingData!.gender : null;
    _nameController.text = _isEdit ? widget.missingData!.name ?? '' : '';
    _ageController.text = _isEdit ? "${widget.missingData!.age ?? 0}" : '';
    _addressController.text = _isEdit ? widget.missingData!.address ?? '' : '';
    _dateController.text =
        _isEdit ? dateInYYYYMMDDFormat(widget.missingData!.missingDate) : '';
    photoName = _isEdit ? 'फोटो जोडलेले आहे' : 'फोटो जोडा';
    longitude = _isEdit ? widget.missingData!.longitude ?? 0.00 : 0.00;
    latitude = _isEdit ? widget.missingData!.latitude ?? 0.00 : 0.00;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(MISSING)),
      body: BlocListener<MissingRegisterBloc, MissingRegisterState>(
        listener: (context, state) {
          if (state is MissingDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is MissingDataSent) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
          }
          if (state is MissingDataEdited) {
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
                    "१८ वर्षावरील आहे का ?",
                    style: Styles.subTitleTextStyle(),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: YES,
                              groupValue: isAbove18,
                              onChanged: (value) {
                                setState(() {
                                  isAbove18 = value;
                                });
                              }),
                          Text(
                            YES,
                            style: Styles.subTitleTextStyle(),
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
                              groupValue: isAbove18,
                              onChanged: (value) {
                                setState(() {
                                  isAbove18 = value;
                                });
                              }),
                          Text(
                            NO,
                            style: Styles.subTitleTextStyle(),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              spacer(),
              buildTextField(_nameController, NAME),
              spacer(),
              buildTextField(_ageController, AGE),
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
                      style: Styles.subTitleTextStyle()),
                  const SizedBox(width: 12),
                  Text("$LATITUDE: $latitude",
                      style: Styles.subTitleTextStyle()),
                ],
              ),
              spacer(),
              buildDateTextField(
                  context, _dateController, "मिसिंग झाल्याची तारीख"),
              spacer(),
              CustomButton(
                  text: DO_REGISTER,
                  onTap: () {
                    _registerMissingData();
                  })
            ],
          ),
        )),
      ),
    );
  }

  _registerMissingData() async {
    MissingData _missingData = MissingData(
        id: _isEdit ? widget.missingData!.id : null,
        isAdult: isAbove18 == YES,
        name: _nameController.text,
        age: parseInt(_ageController.text),
        gender: gender,
        photo: photo?.path != null
            ? await MultipartFile.fromFile(photo!.path)
            : null,
        address: _addressController.text,
        latitude: latitude,
        longitude: longitude,
        missingDate: parseDate(_dateController.text));

    _isEdit
        ? BlocProvider.of<MissingRegisterBloc>(context)
            .add(EditMissingData(_missingData))
        : BlocProvider.of<MissingRegisterBloc>(context)
            .add(AddMissingData(_missingData));
  }
}
