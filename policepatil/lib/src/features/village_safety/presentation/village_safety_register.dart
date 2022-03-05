import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils/custom_methods.dart';
import '../../../core/views/widgets/custom_button.dart';
import '../../../core/views/widgets/custom_textfield.dart';
import '../bloc/village_safety_bloc.dart';
import '../models/village_safety_model.dart';

class VillageSafetyRegisterForm extends StatefulWidget {
  const VillageSafetyRegisterForm({Key? key}) : super(key: key);

  @override
  _VillageSafetyRegisterFormState createState() =>
      _VillageSafetyRegisterFormState();
}

class _VillageSafetyRegisterFormState extends State<VillageSafetyRegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(VILLAGE_SAFETY)),
      body: BlocListener<VillageSafetyBloc, VillageSafetyState>(
        listener: (context, state) {
          if (state is VillageSafetyDataSendError) {
            showSnackBar(context, state.message);
          }
          if (state is VillageSafetyDataSent) {
            showSnackBar(context, state.message);
            Navigator.pop(context);
          }
        },
        child: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              spacer(),
              buildTextField(_nameController, NAME),
              spacer(),
              buildTextField(_skillController, "कौशल्य"),
              spacer(),
              buildTextField(_mobileController, MOB_NO),
              spacer(),
              CustomButton(
                  text: DO_REGISTER,
                  onTap: () {
                    _registerVillageSafetyData();
                  })
            ],
          ),
        )),
      ),
    );
  }

  _registerVillageSafetyData() {
    VillageSafetyData _helperData = VillageSafetyData(
        name: _nameController.text,
        mobile: int.parse(_mobileController.text),
        skill: _skillController.text);

    BlocProvider.of<VillageSafetyBloc>(context)
        .add(AddVillageSafetyData(_helperData));
  }
}
