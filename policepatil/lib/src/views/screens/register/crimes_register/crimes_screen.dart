import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';

import '../../../views.dart';

class CrimesScreen extends StatefulWidget {
  const CrimesScreen({Key? key}) : super(key: key);

  @override
  _CrimesScreenState createState() => _CrimesScreenState();
}

class _CrimesScreenState extends State<CrimesScreen> {
  String? _chosenValue;
  final TextEditingController _noController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final List<String> _crimesTypes = [
    "शरीरा विरुद्ध",
    "माला विरुद्ध",
    "महिलांविरुद्ध",
    "अपघात",
    "इतर अपराध"
  ];

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
        child: Column(
          children: [
            spacer(),
            buildDropButton(
                value: _chosenValue,
                items: _crimesTypes,
                hint: "गुन्ह्याचा प्रकार निवडा",
                onChanged: (String? value) {
                  setState(() {
                    _chosenValue = value;
                  });
                }),
            spacer(),
            buildTextField(_noController, "गुन्हा रजिस्टर नंबर"),
            spacer(),
            buildDateTextField(context, _dateController, DATE),
            spacer(),
            buildTimeTextField(context, _timeController, TIME),
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
