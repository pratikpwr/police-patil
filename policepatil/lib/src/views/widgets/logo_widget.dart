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
        Image.asset(ImageConstants.policeLogo),
        const SizedBox(
          height: 12,
        ),
        Text(
          PolicePatilApp,
          style: GoogleFonts.poppins(
              fontSize: 28, fontWeight: FontWeight.w600, color: Text_Color),
        )
      ],
    );
  }
}
