import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';

import '../views.dart';

class MandhanScreen extends StatelessWidget {
  const MandhanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        MANDHAN,
        style: GoogleFonts.poppins(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      )),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              spacer(),
              RegistersButton(
                  text: "हजेरीबाबतचे स्वयंघोषणापत्र",
                  imageUrl: ImageConstants.IMG_CERTIFICATE,
                  onTap: () {}),
              spacer(),
              RegistersButton(
                  text: "पो. पाटलांनी घेतलेल्या बैठकी",
                  imageUrl: ImageConstants.IMG_MEETING,
                  onTap: () {}),
              spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
