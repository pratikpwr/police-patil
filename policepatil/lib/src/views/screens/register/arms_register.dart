import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';

class ArmsRegScreen extends StatefulWidget {
  const ArmsRegScreen({Key? key}) : super(key: key);

  @override
  State<ArmsRegScreen> createState() => _ArmsRegScreenState();
}

class _ArmsRegScreenState extends State<ArmsRegScreen> {
  String? _chosenValue;

  final List<String> _armsRegTypes = <String>[
    "शस्त्र परवानाधारक",
    "स्फोटक पदार्थ विक्री ",
    "स्फोटक जवळ बाळगणारे",
    "स्फोटक उडविणारे"
  ];

  Position? _position;
  final TextEditingController _longController = TextEditingController();
  final TextEditingController _latController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _adharController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _certificateNoController =
      TextEditingController();
  final TextEditingController _certificateExpiryController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ARMS_COLLECTIONS,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                spacer(),
                buildDropButton(
                    value: _chosenValue,
                    items: _armsRegTypes,
                    hint: "प्रकार निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    }),
                spacer(),
                buildTextField(_nameController, NAME),
                spacer(),
                buildTextField(_adharController, "आधार क्र."),
                spacer(),
                buildTextField(_phoneController, MOB_NO),
                spacer(),
                buildTextField(_addressController, ADDRESS),
                spacer(),
                buildTextField(_longController, LONGITUDE),
                spacer(),
                buildTextField(_latController, LATITUDE),
                spacer(),
                CustomButton(
                    text: SELECT_LOCATION, //📌
                    onTap: () async {
                      _position = await determinePosition();
                      _longController.text = _position!.longitude.toString();
                      _latController.text = _position!.latitude.toString();
                    }),
                spacer(),
                buildTextField(_certificateNoController, "परवाना क्रमांक"),
                spacer(),
                buildTextField(
                    _certificateExpiryController, "परवान्याची वैधता कालावधी"),
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
