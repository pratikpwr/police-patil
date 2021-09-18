import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';

class WatchRegScreen extends StatefulWidget {
  const WatchRegScreen({Key? key}) : super(key: key);

  @override
  State<WatchRegScreen> createState() => _WatchRegScreenState();
}

class _WatchRegScreenState extends State<WatchRegScreen> {
  String? _chosenValue;

  final List<String> _watchRegTypes = <String>[
    "भटक्या टोळी",
    "सराईत गुन्हेगार",
    "फरार आरोपी",
    "तडीपार आरोपी",
    "स्टॅंडिंग वॉरंट"
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();
  final TextEditingController _workController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          WATCH_REGISTER,
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
              buildDropButton(
                  value: _chosenValue,
                  items: _watchRegTypes,
                  hint: "निगराणी प्रकार निवडा",
                  onChanged: (String? value) {
                    setState(() {
                      _chosenValue = value;
                    });
                  }),
              spacer(),
              buildTextField(_nameController, NAME),
              spacer(),
              buildTextField(_phoneController, MOB_NO),
              spacer(),
              buildTextField(_addressController, ADDRESS),
              spacer(),
              TextField(
                controller: _otherController,
                style: GoogleFonts.poppins(fontSize: 14),
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: OTHER_INFO,
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
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
        ),
      ),
    );
  }
}
