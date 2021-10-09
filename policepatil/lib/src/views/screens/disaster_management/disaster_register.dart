import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class DisasterRegFormScreen extends StatefulWidget {
  const DisasterRegFormScreen({Key? key}) : super(key: key);

  @override
  State<DisasterRegFormScreen> createState() => _DisasterRegFormScreenState();
}

class _DisasterRegFormScreenState extends State<DisasterRegFormScreen> {
  String? _chosenType;
  String? _chosenSubType;
  final _disasterTypes = ["नैसर्गिक", "मानवनिर्मित"];
  List<String>? _subTypes;
  final _naturalTypes = [
    "दरड",
    "पूर",
    "दुष्काळ",
    "भुकंप",
    "विज",
    "वणवा",
    "इतर",
  ];
  final _manMadeTypes = [
    "विस्फोट",
    "आग",
    "मोठे अपघात",
    "इतर",
  ];

  final TextEditingController _casualityController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          REGISTER_DISASTER,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<DisasterRegisterBloc, DisasterRegisterState>(
        listener: (context, state) {
          if (state is DisasterDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is DisasterDataSent) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                spacer(),
                buildDropButton(
                    value: _chosenType,
                    items: _disasterTypes,
                    hint: "आपत्ती प्रकार निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        _chosenType = value;
                        _subTypes = _getSubType(value!);
                        _chosenSubType = null;
                      });
                    }),
                spacer(),
                _chosenType != null
                    ? buildDropButton(
                        value: _chosenSubType,
                        items: _subTypes!,
                        hint: "आपत्ती उपप्रकार निवडा",
                        onChanged: (String? value) {
                          setState(() {
                            _chosenSubType = value;
                          });
                        })
                    : spacer(height: 0),
                spacer(),
                buildDateTextField(context, _dateController, DATE),
                spacer(),
                buildTextField(_levelController, "आपत्तीचे स्वरुप"),
                spacer(),
                buildTextField(_casualityController, "जिवितहानी संख्या"),
                spacer(),
                CustomButton(
                    text: DO_REGISTER,
                    onTap: () {
                      _registerDisasterData();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  _registerDisasterData() {
    DateFormat _format = DateFormat("yyyy-MM-dd");

    DisasterData _disasterData = DisasterData(
        type: _chosenType,
        subtype: _chosenSubType,
        date: _format.parse(_dateController.text),
        casuality: int.parse(_casualityController.text),
        level: _levelController.text);

    BlocProvider.of<DisasterRegisterBloc>(context)
        .add(AddDisasterData(_disasterData));
  }

  List<String> _getSubType(String mainType) {
    if (mainType == "नैसर्गिक") {
      return _naturalTypes;
    } else if (mainType == "मानवनिर्मित") {
      return _manMadeTypes;
    } else {
      return ["अगोदर प्रकार निवडा"];
    }
  }
}
