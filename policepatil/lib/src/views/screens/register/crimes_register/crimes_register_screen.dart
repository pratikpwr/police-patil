import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/shared.dart';

import '../../../views.dart';

class CrimeRegFormScreen extends StatefulWidget {
  const CrimeRegFormScreen({Key? key}) : super(key: key);

  @override
  _CrimeRegFormScreenState createState() => _CrimeRegFormScreenState();
}

class _CrimeRegFormScreenState extends State<CrimeRegFormScreen> {
  final _bloc = CrimeRegisterBloc();
  final TextEditingController _noController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(CRIMES),
      ),
      body: BlocListener<CrimeRegisterBloc, CrimeRegisterState>(
        listener: (context, state) {
          if (state is CrimeDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is CrimeDataSent) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
          }
        },
        child: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              spacer(),
              buildDropButton(
                  value: _bloc.chosenValue,
                  items: _bloc.crimesTypes,
                  hint: "गुन्ह्याचा प्रकार निवडा",
                  onChanged: (String? value) {
                    setState(() {
                      _bloc.chosenValue = value;
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
                    _registerCrimeData();
                  })
            ],
          ),
        )),
      ),
    );
  }

  _registerCrimeData() {
    DateFormat _format = DateFormat("yyyy-MM-dd HH:mm");
    CrimeData _crimeData = CrimeData(
        type: _bloc.chosenValue,
        registerNumber: _noController.text,
        date: _format.parse(_dateController.text + " " + _timeController.text),
        time: _timeController.text);

    BlocProvider.of<CrimeRegisterBloc>(context).add(AddCrimeData(_crimeData));
  }
}
