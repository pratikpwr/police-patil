import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/modules/collection_register/bloc/collect_register_bloc.dart';
import 'package:shared/shared.dart';

class CollectRegFormScreen extends StatefulWidget {
  const CollectRegFormScreen({Key? key}) : super(key: key);

  @override
  State<CollectRegFormScreen> createState() => _CollectRegFormScreenState();
}

class _CollectRegFormScreenState extends State<CollectRegFormScreen> {
  String? _chosenValue;

  final List<String> _collectionType = <String>[
    "बेवारस वाहने",
    "दागिने",
    "गौण खनिज",
    "इतर"
  ];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  Position? _position;
  double _longitude = 0.00;
  double _latitude = 0.00;

  String _photoName = "फोटो जोडा";
  File? _photoImage;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          COLLECTION_REGISTER,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
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
                          value: _chosenValue,
                          items: _collectionType,
                          hint: "जप्ती मालाचा प्रकार निवडा",
                          onChanged: (String? value) {
                            setState(() {
                              _chosenValue = value;
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
                      buildDateTextField(context, _dateController, DATE),
                      spacer(),
                      buildTextField(_detailsController, "जप्ती मालाचे वर्णन"),
                      spacer(),
                      AttachButton(
                        text: _photoName,
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'फोटो काढा अथवा गॅलरी मधून निवडा',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          final pickedImage =
                                              await picker.pickImage(
                                                  source: ImageSource.camera);
                                          setState(() {
                                            if (pickedImage != null) {
                                              _photoImage =
                                                  File(pickedImage.path);
                                            } else {
                                              debugPrint('No image selected.');
                                            }
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'कॅमेरा',
                                          style:
                                              GoogleFonts.poppins(fontSize: 14),
                                        )),
                                    TextButton(
                                        onPressed: () async {
                                          final pickedImage =
                                              await picker.pickImage(
                                                  source: ImageSource.gallery);
                                          setState(() {
                                            if (pickedImage != null) {
                                              _photoImage =
                                                  File(pickedImage.path);
                                            } else {
                                              debugPrint('No image selected.');
                                            }
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'गॅलरी',
                                          style:
                                              GoogleFonts.poppins(fontSize: 14),
                                        ))
                                  ],
                                );
                              });
                        },
                      ),
                      spacer(),
                      CustomButton(
                          text: DO_REGISTER,
                          onTap: () {
                            _registerCollectionData();
                          })
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }

  _registerCollectionData() {
    DateFormat _format = DateFormat("yyyy-MM-dd");
    CollectionData _collectionData = CollectionData(
      type: _chosenValue!,
      address: _addressController.text,
      date: _format.parse(_dateController.text),
      description: _detailsController.text,
      latitude: _latitude,
      longitude: _longitude,
      photo: _photoImage?.path,
    );

    BlocProvider.of<CollectRegisterBloc>(context)
        .add(AddCollectionData(_collectionData));
  }
}
