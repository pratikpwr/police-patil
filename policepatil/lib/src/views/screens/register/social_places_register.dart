import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:shared/shared.dart';

import '../../views.dart';

class SocialPlacesRegFormScreen extends StatefulWidget {
  const SocialPlacesRegFormScreen({Key? key}) : super(key: key);

  @override
  State<SocialPlacesRegFormScreen> createState() =>
      _SocialPlacesRegFormScreenState();
}

class _SocialPlacesRegFormScreenState extends State<SocialPlacesRegFormScreen> {
  final _bloc = PublicPlaceRegisterBloc();
  Position? _position;

  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _situationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          SOCIAL_PLACES,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
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
        },
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            spacer(),
            buildDropButton(
                value: _bloc.chosenValue,
                items: _bloc.socialPlaceTypes,
                hint: "सार्वजनिक महत्त्वाचे स्थळ निवडा",
                onChanged: (String? value) {
                  setState(() {
                    _bloc.chosenValue = value;
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
                            groupValue: _bloc.isCCTV,
                            onChanged: (value) {
                              setState(() {
                                _bloc.isCCTV = value;
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
                            groupValue: _bloc.isCCTV,
                            onChanged: (value) {
                              setState(() {
                                _bloc.isCCTV = value;
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
            _bloc.isIssue == YES
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
                                      groupValue: _bloc.isCrimeReg,
                                      onChanged: (value) {
                                        setState(() {
                                          _bloc.isCrimeReg = value;
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
                                      groupValue: _bloc.isCrimeReg,
                                      onChanged: (value) {
                                        setState(() {
                                          _bloc.isCrimeReg = value;
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
            CustomButton(
                text: DO_REGISTER,
                onTap: () {
                  _registerPlaceData();
                })
          ]),
        )),
      ),
    );
  }

  _registerPlaceData() {
    PlaceData _placeData = PlaceData(
        place: _bloc.chosenValue,
        address: _placeController.text,
        latitude: _bloc.latitude,
        longitude: _bloc.longitude,
        photo: _bloc.photo?.path,
        isCCTV: _bloc.isCCTV == YES ? true : false,
        isIssue: _bloc.isIssue == YES ? true : false,
        issueReason: _reasonController.text,
        issueCondition: _situationController.text,
        isCrimeRegistered: _bloc.isCrimeReg == YES ? true : false);

    BlocProvider.of<PublicPlaceRegisterBloc>(context)
        .add(AddPublicPlaceData(_placeData));
  }
}
