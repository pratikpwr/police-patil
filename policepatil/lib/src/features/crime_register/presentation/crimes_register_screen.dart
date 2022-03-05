import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils/custom_methods.dart';
import '../../../core/views/widgets/custom_button.dart';
import '../../../core/views/widgets/custom_date_textfield.dart';
import '../../../core/views/widgets/custom_dropdown.dart';
import '../../../core/views/widgets/custom_textfield.dart';
import '../../../core/views/widgets/custom_time_inputfield.dart';
import '../bloc/crime_register_bloc.dart';
import '../models/crime_model.dart';

class CrimeRegFormScreen extends StatefulWidget {
  CrimeRegFormScreen({Key? key, this.crimesData}) : super(key: key);
  CrimeData? crimesData;

  @override
  _CrimeRegFormScreenState createState() => _CrimeRegFormScreenState();
}

class _CrimeRegFormScreenState extends State<CrimeRegFormScreen> {
  final TextEditingController _noController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  bool _isEdit = false;
  String? chosenValue;
  final List<String> crimesTypes = [
    "शरीरा विरुद्ध",
    "माला विरुद्ध",
    "महिलांविरुद्ध",
    "अपघात",
    "इतर अपराध"
  ];

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  _initializeValues() {
    /// checks is edit mode or not
    _isEdit = widget.crimesData != null;

    chosenValue = _isEdit ? widget.crimesData!.type : null;
    _noController.text = _isEdit ? widget.crimesData!.registerNumber ?? '' : '';
    _timeController.text = _isEdit ? widget.crimesData!.time ?? '' : '';
    _dateController.text =
        _isEdit ? dateInYYYYMMDDFormat(widget.crimesData!.date) : '';
  }

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
          if (state is CrimeDataEdited) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
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
                  value: chosenValue,
                  items: crimesTypes,
                  hint: "गुन्ह्याचा प्रकार निवडा",
                  onChanged: (String? value) {
                    setState(() {
                      chosenValue = value;
                    });
                  }),
              spacer(),
              buildTextField(_noController, "गुन्हा रजिस्टर नंबर"),
              spacer(),
              buildDateTextField(context, _dateController, DATE),
              spacer(),
              buildTimeTextField(context, _timeController, TIME),
              spacer(),
              BlocBuilder<CrimeRegisterBloc, CrimeRegisterState>(
                builder: (context, state) {
                  if (state is CrimeDataSending) {
                    return const Loading();
                  }
                  return CustomButton(
                      text: DO_REGISTER,
                      onTap: () {
                        _registerCrimeData();
                      });
                },
              )
            ],
          ),
        )),
      ),
    );
  }

  _registerCrimeData() {
    CrimeData _crimeData = CrimeData(
        id: _isEdit ? widget.crimesData!.id : null,
        type: chosenValue,
        registerNumber: _noController.text,
        date: parseDate(_dateController.text),
        time: _timeController.text);

    _isEdit
        ? BlocProvider.of<CrimeRegisterBloc>(context)
            .add(EditCrimeData(_crimeData))
        : BlocProvider.of<CrimeRegisterBloc>(context)
            .add(AddCrimeData(_crimeData));
  }
}
