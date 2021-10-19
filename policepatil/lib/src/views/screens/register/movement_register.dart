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

class MovementRegFormScreen extends StatefulWidget {
  const MovementRegFormScreen({Key? key}) : super(key: key);

  @override
  State<MovementRegFormScreen> createState() => _MovementRegFormScreenState();
}

class _MovementRegFormScreenState extends State<MovementRegFormScreen> {
  final _bloc = MovementRegisterBloc();
  Position? _position;
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _leaderController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MOVEMENT_REGISTER,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<MovementRegisterBloc, MovementRegisterState>(
        listener: (context, state) {
          if (state is MovementDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is MovementDataSent) {
            showSnackBar(context, state.message);
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
                    value: _bloc.movementValue,
                    items: _bloc.movementRegTypes,
                    hint: "हालचाली प्रकार निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        _bloc.movementValue = value;
                        _bloc.movementSubRegTypes = _bloc.getSubList();
                        _bloc.movementSubValue = null;
                      });
                    }),
                spacer(),
                _bloc.movementValue != null
                    ? buildDropButton(
                        value: _bloc.movementSubValue,
                        items: _bloc.movementSubRegTypes!,
                        hint: "हालचाली उपप्रकार निवडा",
                        onChanged: (String? value) {
                          setState(() {
                            _bloc.movementSubValue = value;
                          });
                        })
                    : spacer(height: 0),
                spacer(),
                buildTextField(_placeController, PLACE),
                spacer(),
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
                spacer(),
                buildDateTextField(context, _dateController, DATE),
                spacer(),
                buildTimeTextField(context, _timeController, TIME),
                spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      IS_ISSUE,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: YES,
                                groupValue: _bloc.isIssue,
                                onChanged: (value) {
                                  setState(() {
                                    _bloc.isIssue = value;
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
                                groupValue: _bloc.isIssue,
                                onChanged: (value) {
                                  setState(() {
                                    _bloc.isIssue = value;
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
                buildTextField(
                    _leaderController, "नेतृत्त्व करणाऱ्या  व्यक्तीचे नाव"),
                spacer(),
                buildTextField(_countController, ATTENDANCE),
                spacer(),
                buildTextField(
                  _otherController,
                  MOVEMENT_DESCRIPTION,
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
                CustomButton(
                    text: DO_REGISTER,
                    onTap: () {
                      _registerMovementData();
                    }),
                spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _registerMovementData() {
    DateFormat _format = DateFormat("yyyy-MM-dd HH:mm");
    /* TODO : add leader field - can add multiple persons up to 5
              movement type - happened or going to happen
              use date option according to it
    */
    MovementData _movementData = MovementData(
        type: _bloc.movementValue,
        subtype: _bloc.movementSubValue,
        address: _placeController.text,
        latitude: _bloc.latitude,
        longitude: _bloc.longitude,
        datetime:
            _format.parse(_dateController.text + " " + _timeController.text),
        issue: _bloc.isIssue == YES ? true : false,
        attendance: int.parse(_countController.text),
        description: _otherController.text,
        photo: _bloc.photo?.path);

    BlocProvider.of<MovementRegisterBloc>(context)
        .add(AddMovementData(_movementData));
  }
}
