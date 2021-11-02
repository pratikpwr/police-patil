import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:policepatil/src/views/widgets/attach_button.dart';
import 'package:shared/modules/watch_register/bloc/watch_register_bloc.dart';
import 'package:shared/shared.dart';

class WatchRegFormScreen extends StatefulWidget {
  const WatchRegFormScreen({Key? key}) : super(key: key);

  @override
  State<WatchRegFormScreen> createState() => _WatchRegFormScreenState();
}

class _WatchRegFormScreenState extends State<WatchRegFormScreen> {
  Position? _position;

  final _bloc = WatchRegisterBloc();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

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
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                spacer(),
                buildDropButton(
                    value: _bloc.chosenValue,
                    items: _bloc.watchRegTypes,
                    hint: "निगराणी प्रकार निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        _bloc.chosenValue = value;
                      });
                    }),
                spacer(),
                buildTextField(_nameController, NAME),
                spacer(),
                buildTextField(_phoneController, MOB_NO),
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
                // spacer(),
                // GPSWidget(_longitude, _latitude),
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
                CustomButton(
                    text: DO_REGISTER,
                    onTap: () {
                      _registerWatchData();
                    }),
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
        type: _bloc.chosenValue,
        name: _nameController.text,
        mobile: parseInt(_phoneController.text),
        photo: _bloc.photo?.path != null
            ? await MultipartFile.fromFile(_bloc.photo!.path)
            : " ",
        aadhar: _bloc.photo?.path != null
            ? await MultipartFile.fromFile(_bloc.photo!.path)
            : " ",
        address: _addressController.text,
        latitude: _bloc.latitude,
        longitude: _bloc.longitude,
        description: _otherController.text);

    BlocProvider.of<WatchRegisterBloc>(context).add(AddWatchData(_watchData));
  }
}
