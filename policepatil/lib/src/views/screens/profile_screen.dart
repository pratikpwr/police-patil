import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/modules/authentication/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          PROFILE,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(UserLogOut());
                Navigator.pushReplacementNamed(context, '/auth');
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      ImageConstants.PROFILE_PIC,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  spacer(),
                  Text(
                    "राजेंद्र पाटील",
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "सासवड, पुणे",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  spacer(height: 20),
                  // buildDetailsRow(Icons.perm_identity, "y585858"),
                  // spacer(height: 8  ),
                  buildDetails("मो. नंबर :", "7397447297"),
                  spacer(height: 8),
                  buildDetails("पत्ता :", "सासवड, पुणे"),
                  spacer(height: 8),
                  buildDetails("नेमणुकीची तारीख :", "12 DEC 2020"),
                  spacer(height: 8),
                  buildDetails("नेमणुकीची मुदत :", "11 DEC 2021"),
                  spacer(height: 8),
                  buildDetails("पो. ठा. पासून गावाचे अंतर :", "20 कि.मी."),
                  spacer(),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildDetails(String title, String text) {
    return Row(
      children: [
        Text(title,
            style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w600)),
        const SizedBox(
          width: 12,
        ),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 18,
          ),
        )
      ],
    );
  }

  Widget buildDetailsRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
