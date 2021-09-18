import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';

class CollectRegScreen extends StatefulWidget {
  const CollectRegScreen({Key? key}) : super(key: key);

  @override
  State<CollectRegScreen> createState() => _CollectRegScreenState();
}

class _CollectRegScreenState extends State<CollectRegScreen> {
  String? _chosenValue;

  final List<String> _collectionType = <String>[
    "बेवारस वाहने",
    "दागिने",
    "गौण खनिज",
    "इतर"
  ];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          COLLECTION_REGISTER,
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
                    items: _collectionType,
                    hint: "जप्ती मालाचा प्रकार निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    }),
                spacer(),
                buildTextField(_addressController, ADDRESS),
                spacer(),
                buildTextField(_dateController, DATE),
                spacer(),
                buildTextField(_detailsController, DESCRIPTION),
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
