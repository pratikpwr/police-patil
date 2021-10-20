import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class DisasterHelperRegisterForm extends StatefulWidget {
  const DisasterHelperRegisterForm({Key? key}) : super(key: key);

  @override
  _DisasterHelperRegisterFormState createState() =>
      _DisasterHelperRegisterFormState();
}

class _DisasterHelperRegisterFormState
    extends State<DisasterHelperRegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(DISASTER_HELPER)),
      body: BlocListener<DisasterHelperBloc, DisasterHelperState>(
        listener: (context, state) {
          if (state is HelperDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is HelperDataSent) {
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
                    _registerHelperData();
                  })
            ],
          ),
        )),
      ),
    );
  }

  _registerHelperData() {
    HelperData _helperData = HelperData(
        name: _nameController.text,
        mobile: int.parse(_mobileController.text),
        skill: _skillController.text);

    BlocProvider.of<DisasterHelperBloc>(context)
        .add(AddHelperData(_helperData));
  }
}
