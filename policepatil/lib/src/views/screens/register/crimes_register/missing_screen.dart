import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';

class MissingScreen extends StatefulWidget {
  const MissingScreen({Key? key}) : super(key: key);

  @override
  _MissingScreenState createState() => _MissingScreenState();
}

class _MissingScreenState extends State<MissingScreen> {
  var _isAbove18;
  String _date = "वेळ आणि तारीख निवडा";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MISSING,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ओळख पटलेली आहे का ?",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: YES,
                            groupValue: _isAbove18,
                            onChanged: (value) {
                              setState(() {
                                _isAbove18 = value;
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
                            groupValue: _isAbove18,
                            onChanged: (value) {
                              setState(() {
                                _isAbove18 = value;
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
            buildTextField(_nameController, NAME),
            spacer(),
            buildTextField(_addressController, ADDRESS),
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
          ],
        ),
      )),
    );
  }
}
