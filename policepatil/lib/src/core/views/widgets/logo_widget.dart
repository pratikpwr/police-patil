import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants.dart';
import '../../utils/custom_methods.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key, required this.logoSize}) : super(key: key);
  final double logoSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          ImageConstants.IMG_POLICE_LOGO,
          height: logoSize,
        ),
        spacer(height: 12),
        Text(
          POLICE_PATIL_APP,
          style: GoogleFonts.poppins(
              fontSize: logoSize > 150.00 ? 28 : 14,
              fontWeight: FontWeight.w600,
              color: TEXT_COLOR),
        ),
        spacer(height: 4),
        Text(
          "पुणे ग्रामीण पोलीस उपक्रम",
          style: GoogleFonts.poppins(fontSize: 12, color: TEXT_COLOR),
        )
      ],
    );
  }
}
