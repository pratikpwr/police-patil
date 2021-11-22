import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class FireRegFormScreen extends StatefulWidget {
  FireRegFormScreen({Key? key, this.fireData}) : super(key: key);
  FireData? fireData;

  @override
  _FireRegFormScreenState createState() => _FireRegFormScreenState();
}

class _FireRegFormScreenState extends State<FireRegFormScreen> {
  Position? _position;
  double longitude = 0.00;
  double latitude = 0.00;
  bool _isEdit = false;
  File? photo;
  String photoName = "फोटो जोडा";
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _lossController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  _initializeValues() {
    /// checks is edit mode or not
    _isEdit = widget.fireData != null;

    _lossController.text = _isEdit ? widget.fireData!.loss ?? '' : '';
    _reasonController.text = _isEdit ? widget.fireData!.reason ?? '' : '';
    _timeController.text = _isEdit ? widget.fireData!.time ?? '' : '';
    _placeController.text = _isEdit ? widget.fireData!.address ?? '' : '';
    _dateController.text =
        _isEdit ? dateInYYYYMMDDFormat(widget.fireData!.date) : '';
    photoName = _isEdit ? 'फोटो जोडलेले आहे' : 'फोटो जोडा';
    longitude = _isEdit ? widget.fireData!.longitude ?? 0.00 : 0.00;
    latitude = _isEdit ? widget.fireData!.latitude ?? 0.00 : 0.00;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(BURNS),
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
          if (state is FireDataEdited) {
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
              buildTextField(_placeController, "घटनास्थळ"),
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
                  Text("$LATITUDE: $latitude",
                      style: Styles.subTitleTextStyle()),
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
              BlocBuilder<FireRegisterBloc, FireRegisterState>(
                builder: (context, state) {
                  if (state is FireDataSending) {
                    return const Loading();
                  }
                  return CustomButton(
                      text: DO_REGISTER,
                      onTap: () {
                        _registerFireData();
                      });
                },
              ),
              spacer()
            ],
          ),
        )),
      ),
    );
  }

  _registerFireData() async {
    FireData _fireData = FireData(
        id: _isEdit ? widget.fireData!.id : null,
        address: _placeController.text,
        latitude: latitude,
        longitude: longitude,
        date: parseDate(_dateController.text),
        time: _timeController.text,
        reason: _reasonController.text,
        loss: _lossController.text,
        photo: photo?.path != null
            ? await MultipartFile.fromFile(photo!.path)
            : null);

    _isEdit
        ? BlocProvider.of<FireRegisterBloc>(context)
            .add(EditFireData(_fireData))
        : BlocProvider.of<FireRegisterBloc>(context)
            .add(AddFireData(_fireData));
  }
}
