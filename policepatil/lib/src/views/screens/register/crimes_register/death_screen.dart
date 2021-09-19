import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';

class DeathScreen extends StatefulWidget {
  const DeathScreen({Key? key}) : super(key: key);

  @override
  _DeathScreenState createState() => _DeathScreenState();
}

class _DeathScreenState extends State<DeathScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DEATHS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(),
      )),
    );
  }
}
