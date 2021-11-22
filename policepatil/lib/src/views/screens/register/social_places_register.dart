import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:shared/shared.dart';

import '../../views.dart';

class SocialPlacesRegFormScreen extends StatefulWidget {
  SocialPlacesRegFormScreen({Key? key, this.placeData}) : super(key: key);
  PlaceData? placeData;

  @override
  State<SocialPlacesRegFormScreen> createState() =>
      _SocialPlacesRegFormScreenState();
}

class _SocialPlacesRegFormScreenState extends State<SocialPlacesRegFormScreen> {
  bool _isEdit = false;
  Position? _position;

  String? chosenValue;

  double longitude = 0.00;
  double latitude = 0.00;

  File? photo;
  String photoName = "फोटो जोडा";

  final List<String> socialPlaceTypes = <String>[
    "रस्ता",
    "पाणवठा",
    "जमीन",
    "पुतळा",
    "धार्मिक स्थळ",
    "इतर"
  ];

  var isIssue;
  var isCCTV;
  var isCrimeReg;

  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _situationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  _initializeValues() {
    /// checks is edit mode or not
    _isEdit = widget.placeData != null;

    /// based on mode if its edit then previous values assigned
    _placeController.text = _isEdit ? widget.placeData!.address ?? '' : '';
    _reasonController.text = _isEdit ? widget.placeData!.issueReason ?? '' : '';
    _situationController.text =
        _isEdit ? widget.placeData!.issueCondition ?? '' : '';
    chosenValue = _isEdit ? widget.placeData!.place : null;
    isCCTV = _isEdit
        ? widget.placeData!.isCCTV != null
            ? YES
            : NO
        : null;
    isIssue = _isEdit ? widget.placeData!.isIssue : null;
    isCrimeReg = _isEdit ? widget.placeData!.isCrimeRegistered : null;
    photoName = _isEdit ? 'फोटो जोडलेले आहे' : 'फोटो जोडा';
    longitude = _isEdit ? widget.placeData!.longitude ?? 0.00 : 0.00;
    latitude = _isEdit ? widget.placeData!.latitude ?? 0.00 : 0.00;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SOCIAL_PLACES),
      ),
      body: BlocListener<PublicPlaceRegisterBloc, PublicPlaceRegisterState>(
        listener: (context, state) {
          if (state is PublicPlaceDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is PublicPlaceDataSent) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
          }
          if (state is PublicPlaceDataEdited) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            spacer(),
            buildDropButton(
                value: chosenValue,
                items: socialPlaceTypes,
                hint: "सार्वजनिक महत्त्वाचे स्थळ निवडा",
                onChanged: (String? value) {
                  setState(() {
                    chosenValue = value;
                  });
                }),
            spacer(),
            buildTextField(_placeController, PLACE),
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
                Text("$LONGITUDE: ${longitude}",
                    style: GoogleFonts.poppins(fontSize: 14)),
                const SizedBox(width: 12),
                Text("$LATITUDE: ${latitude}",
                    style: GoogleFonts.poppins(fontSize: 14)),
              ],
            ),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "सीसीटीव्ही बसवला आहे का ?",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: YES,
                            groupValue: isCCTV,
                            onChanged: (value) {
                              setState(() {
                                isCCTV = value;
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
                            groupValue: isCCTV,
                            onChanged: (value) {
                              setState(() {
                                isCCTV = value;
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "काही वाद आहेत का ?",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: YES,
                            groupValue: isIssue,
                            onChanged: (value) {
                              setState(() {
                                isIssue = value;
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
                            groupValue: isIssue,
                            onChanged: (value) {
                              setState(() {
                                isIssue = value;
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
            isIssue == YES
                ? Column(
                    children: [
                      buildTextField(_reasonController, "वादाचे कारण"),
                      spacer(),
                      buildTextField(_situationController, "वादाची सद्यस्थिती"),
                      spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "गुन्हा दाखल आहे का ?",
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: YES,
                                      groupValue: isCrimeReg,
                                      onChanged: (value) {
                                        setState(() {
                                          isCrimeReg = value;
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
                                      groupValue: isCrimeReg,
                                      onChanged: (value) {
                                        setState(() {
                                          isCrimeReg = value;
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
                    ],
                  )
                : spacer(height: 0),
            BlocBuilder<PublicPlaceRegisterBloc, PublicPlaceRegisterState>(
              builder: (context, state) {
                if (state is PublicPlaceDataSending) {
                  return const Loading();
                }
                return CustomButton(
                    text: DO_REGISTER,
                    onTap: () {
                      _registerPlaceData();
                    });
              },
            )
          ]),
        )),
      ),
    );
  }

  _registerPlaceData() async {
    PlaceData _placeData = PlaceData(
        id: _isEdit ? widget.placeData!.id : null,
        place: chosenValue,
        address: _placeController.text,
        latitude: latitude,
        longitude: longitude,
        photo: photo?.path != null
            ? await MultipartFile.fromFile(photo!.path)
            : null,
        isCCTV: _isEdit ? widget.placeData!.isCCTV : isCCTV == YES,
        isIssue: _isEdit ? widget.placeData!.isIssue : isIssue == YES,
        issueReason: _reasonController.text,
        issueCondition: _situationController.text,
        isCrimeRegistered:
            _isEdit ? widget.placeData!.isCrimeRegistered : isCrimeReg == YES);

    _isEdit
        ? BlocProvider.of<PublicPlaceRegisterBloc>(context)
            .add(EditPublicPlaceData(_placeData))
        : BlocProvider.of<PublicPlaceRegisterBloc>(context)
            .add(AddPublicPlaceData(_placeData));
  }
}
