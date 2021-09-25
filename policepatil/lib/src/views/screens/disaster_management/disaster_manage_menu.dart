import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';

import '../../views.dart';

class DisasterMenuScreen extends StatelessWidget {
  const DisasterMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DISASTER_MANAGEMENT,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            spacer(),
            RegistersButton(
                text: DISASTER_MANAGEMENT + " नियोजन",
                imageUrl: ImageConstants.IMG_DISASTER_HELPER,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const DisasterManageScreen();
                  }));
                }),
            spacer(),
            RegistersButton(
                text: "आपत्ती रजिस्टर करा",
                imageUrl: ImageConstants.IMG_DISASTER_MANAGE,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const DisasterRegScreen();
                  }));
                }),
            spacer(),
          ],
        ),
      ),
    );
  }
}
