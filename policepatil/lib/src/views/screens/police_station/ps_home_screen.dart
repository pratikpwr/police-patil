import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/responsive.dart';
import 'package:policepatil/src/views/widgets/side_menu.dart';

class PSHomeScreen extends StatefulWidget {
  const PSHomeScreen({Key? key}) : super(key: key);

  @override
  _PSHomeScreenState createState() => _PSHomeScreenState();
}

class _PSHomeScreenState extends State<PSHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            const Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DetailsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Responsive.isDesktop(context)
          ? Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      ImageConstants.IMG_ARMS,
                      height: 60,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      ARMS_COLLECTIONS,
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            )
          : Column(),
    );
  }
}
