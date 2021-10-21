import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/modules/collection_register/bloc/collect_register_bloc.dart';
import 'package:shared/shared.dart';

class CollectRegFormScreen extends StatefulWidget {
  const CollectRegFormScreen({Key? key}) : super(key: key);

  @override
  State<CollectRegFormScreen> createState() => _CollectRegFormScreenState();
}

class _CollectRegFormScreenState extends State<CollectRegFormScreen> {
  final _bloc = CollectRegisterBloc();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  Position? _position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(COLLECTION_REGISTER),
      ),
      body: BlocListener<CollectRegisterBloc, CollectRegisterState>(
        listener: (context, state) {
          if (state is CollectionDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is CollectionDataSent) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<CollectRegisterBloc, CollectRegisterState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      spacer(),
                      buildDropButton(
                          value: _bloc.chosenValue,
                          items: _bloc.collectionType,
                          hint: "जप्ती मालाचा प्रकार निवडा",
                          onChanged: (String? value) {
                            setState(() {
                              _bloc.chosenValue = value;
                            });
                          }),
                      spacer(),
                      buildTextField(_addressController, PLACE),
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
                      buildTextField(_detailsController, "जप्ती मालाचे वर्णन"),
                      spacer(),
                      AttachButton(
                        text: _bloc.photoName,
                        onTap: () {
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
                            _registerCollectionData(context);
                          })
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }

  _registerCollectionData(BuildContext context) {
    DateFormat _format = DateFormat("yyyy-MM-dd");
    CollectionData _collectionData = CollectionData(
      type: _bloc.chosenValue!,
      address: _addressController.text,
      date: _format.parse(_dateController.text),
      description: _detailsController.text,
      latitude: _bloc.latitude,
      longitude: _bloc.longitude,
      photo: _bloc.photo!.path,
    );

    BlocProvider.of<CollectRegisterBloc>(context)
        .add(AddCollectionData(_collectionData));
  }
}
