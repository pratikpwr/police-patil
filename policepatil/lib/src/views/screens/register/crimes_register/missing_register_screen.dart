import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:policepatil/src/views/widgets/attach_button.dart';
import 'package:shared/shared.dart';

class MissingRegFormScreen extends StatefulWidget {
  const MissingRegFormScreen({Key? key}) : super(key: key);

  @override
  _MissingRegFormScreenState createState() => _MissingRegFormScreenState();
}

class _MissingRegFormScreenState extends State<MissingRegFormScreen> {
  Position? _position;

  final _bloc = MissingRegisterBloc();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

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
                              groupValue: _bloc.isAbove18,
                              onChanged: (value) {
                                setState(() {
                                  _bloc.isAbove18 = value;
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
                              groupValue: _bloc.isAbove18,
                              onChanged: (value) {
                                setState(() {
                                  _bloc.isAbove18 = value;
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
              buildTextField(_addressController, ADDRESS),
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
                      style: Styles.subTitleTextStyle()),
                  const SizedBox(width: 12),
                  Text("$LATITUDE: ${_bloc.latitude}",
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

  _registerMissingData() {
    DateFormat _format = DateFormat("yyyy-MM-dd");

    MissingData _missingData = MissingData(
        isAdult: _bloc.isAbove18 == YES,
        name: _nameController.text,
        age: int.parse(_ageController.text),
        gender: _bloc.gender,
        photo: _bloc.photo?.path,
        address: _addressController.text,
        latitude: _bloc.latitude,
        longitude: _bloc.longitude,
        missingDate: _format.parse(_dateController.text));

    BlocProvider.of<MissingRegisterBloc>(context)
        .add(AddMissingData(_missingData));
  }
}
