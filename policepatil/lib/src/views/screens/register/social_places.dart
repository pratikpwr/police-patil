import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';

import '../../views.dart';

class SocialPlacesRegScreen extends StatefulWidget {
  const SocialPlacesRegScreen({Key? key}) : super(key: key);

  @override
  State<SocialPlacesRegScreen> createState() => _SocialPlacesRegScreenState();
}

class _SocialPlacesRegScreenState extends State<SocialPlacesRegScreen> {
  String? _chosenValue;

  final List<String> _socialPlaceTypes = <String>[
    "रस्ता",
    "पानवटा",
    "जमीन",
    "पुतळा",
    "धार्मिक स्थळ"
  ];

  var _isCCTV;
  var _isCrimeReg;

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
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: [
          spacer(),
          buildDropButton(
              value: _chosenValue,
              items: _socialPlaceTypes,
              hint: "सार्वजनिक महत्त्वाचे स्थळ निवडा",
              onChanged: (String? value) {
                setState(() {
                  _chosenValue = value;
                });
              }),
          spacer(),
          buildTextField(_reasonController, "वादाचे कारण"),
          spacer(),
          buildTextField(_situationController, "वादाची सद्यस्थिती"),
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
                          groupValue: _isCCTV,
                          onChanged: (value) {
                            setState(() {
                              _isCCTV = value;
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
                          groupValue: _isCCTV,
                          onChanged: (value) {
                            setState(() {
                              _isCCTV = value;
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
                "गुन्हा दाखल आहे का ?",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                          value: YES,
                          groupValue: _isCrimeReg,
                          onChanged: (value) {
                            setState(() {
                              _isCrimeReg = value;
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
                          groupValue: _isCrimeReg,
                          onChanged: (value) {
                            setState(() {
                              _isCrimeReg = value;
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
          CustomButton(
              text: DO_REGISTER,
              onTap: () {
                showSnackBar(context, SAVED);
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) {
                    return const RegisterScreen();
                  }));
                });
              })
        ]),
      )),
    );
  }
}
