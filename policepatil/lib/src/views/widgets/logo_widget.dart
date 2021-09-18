import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(ImageConstants.IMG_POLICE_LOGO),
        const SizedBox(
          height: 12,
        ),
        Text(
          POLICE_PATIL_APP,
          style: GoogleFonts.poppins(
              fontSize: 28, fontWeight: FontWeight.w600, color: TEXT_COLOR),
        )
      ],
    );
  }
}
