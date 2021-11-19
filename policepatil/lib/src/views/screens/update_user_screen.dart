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

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key, required this.user}) : super(key: key);
  final UserData user;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _mobileController = TextEditingController();
  final _assignController = TextEditingController();
  final _lastController = TextEditingController();
  final _distanceController = TextEditingController();
  final _orderNoController = TextEditingController();
  String _photoName = "फोटो जोडा";
  File? _photo;
  Position? _position;
  double _longitude = 0.00;
  double _latitude = 0.00;

  @override
  void initState() {
    setUserPreviousData();
    super.initState();
  }

  void setUserPreviousData() {
    final user = widget.user;
    // _photo.path = user.photo ?? "";

    _nameController.text = user.name ?? "";
    _mobileController.text = "${user.mobile ?? 0}";
    _addressController.text = user.address ?? "";
    _orderNoController.text = user.orderNo ?? "";
    _distanceController.text = "${user.psdistance ?? 0}";
    _latitude = user.latitude ?? 0.00;
    _longitude = user.latitude ?? 0.00;
    _assignController.text = user.joindate == null
        ? ""
        : user.joindate!.toIso8601String().substring(0, 10);
    _lastController.text = user.enddate == null
        ? ""
        : user.enddate!.toIso8601String().substring(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "माहिती अपडेट करा",
        ),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateFailed) {
            showSnackBar(context, state.message);
          }
          if (state is ProfileUpdateSuccess) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return SafeArea(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  AttachButton(
                      text: _photoName,
                      onTap: () {
                        getFileFromDevice(context).then((pickedFile) {
                          setState(() {
                            _photo = pickedFile;
                            _photoName = getFileName(pickedFile!.path);
                          });
                        });
                      }),
                  spacer(),
                  buildTextField(_nameController, NAME),
                  spacer(),
                  buildTextField(_addressController, ADDRESS),
                  spacer(),
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
                  spacer(),
                  buildTextField(_mobileController, "मो. नंबर"),
                  spacer(),
                  buildTextField(
                      _distanceController, "पो. ठा. पासून गावाचे अंतर"),
                  spacer(),
                  buildTextField(_orderNoController, "आदेश क्र."),
                  spacer(),
                  buildDateTextField(
                    context,
                    _assignController,
                    "नेमणुकीची तारीख",
                  ),
                  spacer(),
                  buildDateTextField(
                      context, _lastController, "नेमणुकीची मुदत"),
                  spacer(),
                  CustomButton(
                      text: "माहिती अपडेट करा",
                      onTap: () async {
                        _updateUser();
                      })
                ],
              ),
            ));
          },
        ),
      ),
    );
  }

  _updateUser() async {
    final user = UserData(
        name: _nameController.text,
        address: _addressController.text,
        mobile: parseInt(_mobileController.text),
        photo: _photo?.path != null
            ? await MultipartFile.fromFile(_photo!.path)
            : null,
        latitude: _latitude,
        longitude: _longitude,
        orderNo: _orderNoController.text,
        psdistance: parseInt(_distanceController.text),
        joindate: parseDate(_assignController.text),
        enddate: parseDate(_lastController.text));
    BlocProvider.of<ProfileBloc>(context).add(ChangeUserData(user));
  }
}
