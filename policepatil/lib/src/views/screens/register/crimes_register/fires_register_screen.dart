import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class FireRegFormScreen extends StatefulWidget {
  const FireRegFormScreen({Key? key}) : super(key: key);

  @override
  _FireRegFormScreenState createState() => _FireRegFormScreenState();
}

class _FireRegFormScreenState extends State<FireRegFormScreen> {
  Position? _position;
  final _bloc = FireRegisterBloc();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _lossController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          BURNS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<FireRegisterBloc, FireRegisterState>(
        listener: (context, state) {
          if (state is FireDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is FireDataSent) {
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
              buildTextField(_placeController, "घटनास्थळ"),
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
                  Text("$LATITUDE: ${_bloc.latitude}",
                      style: GoogleFonts.poppins(fontSize: 14)),
                ],
              ),
              spacer(),
              buildDateTextField(context, _dateController, DATE),
              spacer(),
              buildTimeTextField(context, _timeController, TIME),
              spacer(),
              buildTextField(_reasonController, "आगीचे कारण"),
              spacer(),
              buildTextField(_lossController, "अंदाजे झालेले नुकसान"),
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
                    _registerFireData();
                  }),
              spacer()
            ],
          ),
        )),
      ),
    );
  }

  _registerFireData() {
    DateFormat _format = DateFormat("yyyy-MM-dd");
    FireData _fireData = FireData(
        address: _placeController.text,
        latitude: _bloc.latitude,
        longitude: _bloc.longitude,
        date: _format.parse(_dateController.text),
        time: _timeController.text,
        reason: _reasonController.text,
        loss: _lossController.text,
        photo: _bloc.photo?.path);

    BlocProvider.of<FireRegisterBloc>(context).add(AddFireData(_fireData));
  }
}
