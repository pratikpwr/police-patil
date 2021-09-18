import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';

import '../../views.dart';

class IllegalWorksScreen extends StatefulWidget {
  const IllegalWorksScreen({Key? key}) : super(key: key);

  @override
  State<IllegalWorksScreen> createState() => _IllegalWorksScreenState();
}

class _IllegalWorksScreenState extends State<IllegalWorksScreen> {
  String? _chosenValue;

  final List<String> _watchRegTypes = <String>[
    "अवैद्य दारू विक्री करणारे",
    "अवैद्य गुटका विक्री करणारे",
    "जुगार/मटका चालविणारे/खेळणारे",
    "अवैद्य गौण खनिज उत्खनन करणारे वाळू तस्कर",
    "अमली पदार्थ विक्री करणारे"
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _vehicleNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ILLEGAL_WORKS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                spacer(),
                buildDropButton(
                    value: _chosenValue,
                    items: _watchRegTypes,
                    hint: "अवैद्य धंदे प्रकार निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    }),
                spacer(),
                buildTextField(_nameController, NAME),
                spacer(),
                buildTextField(_addressController, ADDRESS),
                spacer(),
                _chosenValue == _watchRegTypes[3] ||
                        _chosenValue == _watchRegTypes[4]
                    ? buildTextField(_vehicleNoController, VEHICLE_NO)
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
            )),
      ),
    );
  }
}
