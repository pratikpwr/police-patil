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

class WatchRegFormScreen extends StatefulWidget {
  WatchRegFormScreen({Key? key, this.watchData}) : super(key: key);
  WatchData? watchData;

  @override
  State<WatchRegFormScreen> createState() => _WatchRegFormScreenState();
}

class _WatchRegFormScreenState extends State<WatchRegFormScreen> {
  Position? _position;

  String? chosenValue;
  double longitude = 0.00;
  double latitude = 0.00;
  final List<String> watchRegTypes = <String>["भटक्या टोळी"];
  String fileName = 'आधार कार्ड जोडा';
  String photoName = "फोटो जोडा";
  File? file;
  File? photo;
  bool _isEdit = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  _initializeValues() {
    /// checks is edit mode or not
    _isEdit = widget.watchData != null;

    /// based on mode if its edit then previous values assigned
    _nameController.text = _isEdit ? widget.watchData!.name ?? '' : '';
    _phoneController.text = "${_isEdit ? widget.watchData!.mobile ?? '' : ''}";
    _addressController.text = _isEdit ? widget.watchData!.address ?? '' : '';
    _otherController.text = _isEdit ? widget.watchData!.description ?? '' : '';
    chosenValue = _isEdit ? widget.watchData!.type : null;
    fileName = _isEdit ? 'आधार कार्ड जोडलेले आहे' : 'आधार कार्ड जोडा';
    photoName = _isEdit ? 'फोटो जोडलेले आहे' : 'फोटो जोडा';
    longitude = _isEdit ? widget.watchData!.longitude ?? 0.00 : 0.00;
    latitude = _isEdit ? widget.watchData!.latitude ?? 0.00 : 0.00;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(WATCH_REGISTER),
      ),
      body: BlocListener<WatchRegisterBloc, WatchRegisterState>(
        listener: (context, state) {
          if (state is WatchDataSendError) {
            debugPrint(state.error);
            showSnackBar(context, state.error);
          }
          if (state is WatchDataSent) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
          }
          if (state is WatchDataEdited) {
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
                    items: watchRegTypes,
                    hint: "निगराणी प्रकार निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        chosenValue = value;
                      });
                    }),
                spacer(),
                buildTextField(_nameController, NAME),
                spacer(),
                buildTextField(_phoneController, MOB_NO),
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
                AttachButton(
                  text: fileName,
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
                // spacer(),
                // GPSWidget(_longitude, _latitude),
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
                TextField(
                  controller: _otherController,
                  style: GoogleFonts.poppins(fontSize: 14),
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: OTHER_INFO,
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                spacer(),
                BlocBuilder<WatchRegisterBloc, WatchRegisterState>(
                  builder: (context, state) {
                    if (state is WatchDataSending) {
                      return const Loading();
                    }
                    return CustomButton(
                        text: DO_REGISTER,
                        onTap: () {
                          _registerWatchData();
                        });
                  },
                ),
                spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _registerWatchData() async {
    WatchData _watchData = WatchData(
        id: _isEdit ? widget.watchData!.id : null,
        type: chosenValue,
        name: _nameController.text,
        mobile: parseInt(_phoneController.text),
        photo: photo?.path != null
            ? await MultipartFile.fromFile(photo!.path)
            : null,
        aadhar: photo?.path != null
            ? await MultipartFile.fromFile(photo!.path)
            : null,
        address: _addressController.text,
        latitude: latitude,
        longitude: longitude,
        description: _otherController.text);

    _isEdit
        ? BlocProvider.of<WatchRegisterBloc>(context)
            .add(EditWatchData(_watchData))
        : BlocProvider.of<WatchRegisterBloc>(context)
            .add(AddWatchData(_watchData));
  }
}
