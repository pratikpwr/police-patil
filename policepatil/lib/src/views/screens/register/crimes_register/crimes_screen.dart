import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';

class CrimesScreen extends StatefulWidget {
  const CrimesScreen({Key? key}) : super(key: key);

  @override
  _CrimesScreenState createState() => _CrimesScreenState();
}

class _CrimesScreenState extends State<CrimesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          CRIMES,
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
