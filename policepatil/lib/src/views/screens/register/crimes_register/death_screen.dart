import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';

class DeathScreen extends StatefulWidget {
  const DeathScreen({Key? key}) : super(key: key);

  @override
  _DeathScreenState createState() => _DeathScreenState();
}

class _DeathScreenState extends State<DeathScreen> {
  var _isIdentified;

  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

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
                            groupValue: _isIdentified,
                            onChanged: (value) {
                              setState(() {
                                _isIdentified = value;
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
                            groupValue: _isIdentified,
                            onChanged: (value) {
                              setState(() {
                                _isIdentified = value;
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
            _isIdentified == YES
                ? Column(
                    children: [
                      buildTextField(_nameController, NAME),
                      spacer(),
                      buildTextField(_addressController, ADDRESS),
                      spacer(),
                      buildTextField(_placeController, "कोठे सापडले ठिकाण"),
                      spacer(),
                      buildTextField(_reasonController, "मरणाचे प्राथमिक कारण")
                    ],
                  )
                : spacer(height: 0),
            _isIdentified == NO
                ? Column(
                    children: [
                      buildTextField(_nameController, "अंदाजे वय"),
                      spacer(),
                      buildTextField(_placeController, "कोठे सापडले ठिकाण"),
                      spacer(),
                      buildTextField(_reasonController, "मरणाचे प्राथमिक कारण")
                    ],
                  )
                : spacer(height: 0),
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
