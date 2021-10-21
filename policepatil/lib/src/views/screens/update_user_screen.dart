import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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

  final _villageController = TextEditingController();
  final _addressController = TextEditingController();

  final _mobileController = TextEditingController();

  final _assignController = TextEditingController();

  final _lastController = TextEditingController();

  final _distanceController = TextEditingController();
  String _photoName = "फोटो जोडा";
  File? _photo;
  Position? _position;
  double _longitude = 0.00;
  double _latitude = 0.00;

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    _nameController.text = user.name ?? "";
    _mobileController.text = user.mobile.toString();
    _addressController.text = user.address ?? "";
    _villageController.text = user.village ?? "";
    _distanceController.text = user.psdistance.toString();
    // _assignController.text = user.joindate.toIso8601String();
    // _lastController.text = user.enddate.toIso8601String();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "माहिती उपडेट करा",
          style: Styles.appBarTextStyle(),
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
                  buildTextField(_villageController, "गाव"),
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
                      text: "माहिती उपडेट करा",
                      onTap: () {
                        DateFormat _format = DateFormat("yyyy-MM-dd");
                        final user = UserData(
                            name: _nameController.text,
                            address: _addressController.text,
                            mobile: int.parse(_mobileController.text),
                            village: _villageController.text,
                            photo: _photo?.path,
                            latitude: _latitude,
                            longitude: _longitude,
                            psdistance: int.parse(_distanceController.text),
                            joindate: _format.parse(_assignController.text),
                            enddate: _format.parse(_lastController.text));
                        BlocProvider.of<ProfileBloc>(context)
                            .add(ChangeUserData(user));
                      })
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
