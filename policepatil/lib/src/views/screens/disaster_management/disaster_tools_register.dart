import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:shared/shared.dart';

import '../../views.dart';

class DisasterToolsRegisterForm extends StatefulWidget {
  const DisasterToolsRegisterForm({Key? key}) : super(key: key);

  @override
  _DisasterToolsRegisterFormState createState() =>
      _DisasterToolsRegisterFormState();
}

class _DisasterToolsRegisterFormState extends State<DisasterToolsRegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(DISASTER_TOOLS)),
      body: BlocListener<DisasterToolsBloc, DisasterToolsState>(
        listener: (context, state) {
          if (state is ToolsDataSendError) {
            showSnackBar(context, state.error);
          }
          if (state is ToolsDataSent) {
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
              buildTextField(_nameController, "उपलब्ध साधनाचे नाव"),
              spacer(),
              buildTextField(_quantityController, "संख्या"),
              spacer(),
              CustomButton(
                  text: DO_REGISTER,
                  onTap: () {
                    _registerToolsData();
                  })
            ],
          ),
        )),
      ),
    );
  }

  _registerToolsData() {
    ToolsData _toolsData = ToolsData(
        name: _nameController.text,
        quantity: int.parse(_quantityController.text));

    BlocProvider.of<DisasterToolsBloc>(context).add(AddToolsData(_toolsData));
  }
}
