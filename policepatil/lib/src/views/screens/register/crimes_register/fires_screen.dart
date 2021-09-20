import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';

class FiresScreen extends StatefulWidget {
  const FiresScreen({Key? key}) : super(key: key);

  @override
  _FiresScreenState createState() => _FiresScreenState();
}

class _FiresScreenState extends State<FiresScreen> {
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _lossController = TextEditingController();
  String _date = "वेळ आणि तारीख निवडा";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          BURNS,
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
            buildTextField(_placeController, "घटनास्थळ"),
            spacer(),
            CustomButton(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(2021, 1, 1),
                  maxTime: DateTime(2021, 12, 31),
                  onChanged: (date) {
                    setState(() {
                      _date = date.toIso8601String().substring(0, 10);
                    });
                  },
                  onConfirm: (date) {
                    setState(() {
                      _date = date.toIso8601String().substring(0, 10);
                    });
                  },
                  currentTime: DateTime.now(),
                );
              },
              text: _date,
            ),
            spacer(),
            buildTextField(_reasonController, "आगीचे कारण"),
            spacer(),
            buildTextField(_lossController, "अंदाजे झालेले नुकसान"),
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
