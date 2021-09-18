import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';

class MovementRegScreen extends StatefulWidget {
  const MovementRegScreen({Key? key}) : super(key: key);

  @override
  State<MovementRegScreen> createState() => _MovementRegScreenState();
}

class _MovementRegScreenState extends State<MovementRegScreen> {
  String? _movementValue;
  String? _movementSubValue;
  final List<String> _movementRegTypes = <String>[
    "राजकीय हालचाली",
    "धार्मिक हालचाली",
    "जातीय हालचाली",
    "संस्कृती हालचाली"
  ];

  List<String>? _movementSubRegTypes;

  final List<String> _politicalMovements = <String>[
    "आंदोलने",
    "सभा",
    "निवडणुका",
    "राजकीय संघर्ष/वाद-विवाद"
  ];
  final List<String> _religionMovements = <String>[
    "यात्रा/उत्सव",
    "घेण्यात येणारे कार्यक्रम",
    "धार्मिक प्रसंगी उद्भवणारे वाद-विवाद"
  ];
  final List<String> _castMovements = <String>["कार्यक्रम", "जातीय वाद-विवाद"];
  final List<String> _culturalMovements = <String>[
    "जयंती/पुण्यतिथी",
    "सण/उत्सव",
    "इतर सांस्कृतिक हालचाली"
  ];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MOVEMENT_REGISTER,
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
                  value: _movementValue,
                  items: _movementRegTypes,
                  hint: "हालचाली प्रकार निवडा",
                  onChanged: (String? value) {
                    setState(() {
                      _movementValue = value;
                      _movementSubRegTypes = _getSubList(_movementValue);
                    });
                  }),
              spacer(),
              _movementValue != null
                  ? buildDropButton(
                      value: _movementSubValue,
                      items: _movementSubRegTypes!,
                      hint: "हालचाली उपप्रकार निवडा",
                      onChanged: (String? value) {
                        setState(() {
                          _movementSubValue = value;
                        });
                      })
                  : spacer(height: 0),
              spacer(),
              buildTextField(
                _dateController,
                "दिनांक",
              ),
              spacer(),
              buildTextField(
                _addressController,
                "पत्ता",
              ),
              spacer(),
              buildTextField(
                _otherController,
                "इतर माहिती",
              ),
              spacer(),
              CustomButton(
                  text: "रजिस्टर करा",
                  onTap: () {
                    showSnackBar(context, "सेव झाले");
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

  List<String> _getSubList(String? movementValue) {
    if (movementValue == "राजकीय हालचाली") {
      return _politicalMovements;
    } else if (movementValue == "धार्मिक हालचाली") {
      return _religionMovements;
    } else if (movementValue == "जातीय हालचाली") {
      return _castMovements;
    } else if (movementValue == "संस्कृती हालचाली") {
      return _culturalMovements;
    } else {
      return ["अगोदर हालचाली प्रकार निवडा"];
    }
  }
}
