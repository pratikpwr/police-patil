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
  const IllegalWorksFormScreen({Key? key}) : super(key: key);

  @override
  State<IllegalWorksFormScreen> createState() => _IllegalWorksFormScreenState();
}

class _IllegalWorksFormScreenState extends State<IllegalWorksFormScreen> {
  final _bloc = IllegalRegisterBloc();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _vehicleNoController = TextEditingController();

  Position? _position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ILLEGAL_WORKS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
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
                        hint: "अवैद्य धंदे प्रकार निवडा",
                        onChanged: (String? value) {
                          setState(() {
                            _bloc.chosenValue = value;
                          });
                        }),
                    spacer(),
                    buildTextField(_nameController, NAME),
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
                            style: GoogleFonts.poppins(fontSize: 14)),
                        const SizedBox(width: 12),
                        Text("$LATITUDE: ${_bloc.latitude}",
                            style: GoogleFonts.poppins(fontSize: 14)),
                      ],
                    ),
                    spacer(),
                    _bloc.chosenValue == _bloc.watchRegTypes[3] ||
                            _bloc.chosenValue == _bloc.watchRegTypes[4]
                        ? buildTextField(_vehicleNoController, VEHICLE_NO)
                        : spacer(height: 0),
                    spacer(),
                    CustomButton(
                        text: DO_REGISTER,
                        onTap: () {
                          _registerIllegalData();
                        })
                  ],
                )),
          )),
    );
  }

  _registerIllegalData() {
    IllegalData _illegalData = IllegalData(
      type: _bloc.chosenValue,
      name: _nameController.text,
      photo: _bloc.photo?.path,
      address: _addressController.text,
      latitude: _bloc.latitude,
      longitude: _bloc.longitude,
    );

    BlocProvider.of<IllegalRegisterBloc>(context)
        .add(AddIllegalData(_illegalData));
  }
}
