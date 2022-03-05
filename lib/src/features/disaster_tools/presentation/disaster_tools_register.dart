import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils/custom_methods.dart';
import '../../../core/views/widgets/custom_button.dart';
import '../../../core/views/widgets/custom_dropdown.dart';
import '../../../core/views/widgets/custom_textfield.dart';
import '../bloc/disaster_tools_bloc.dart';
import '../models/tools_model.dart';

class DisasterToolsRegisterForm extends StatefulWidget {
  const DisasterToolsRegisterForm({Key? key}) : super(key: key);

  @override
  _DisasterToolsRegisterFormState createState() =>
      _DisasterToolsRegisterFormState();
}

class _DisasterToolsRegisterFormState extends State<DisasterToolsRegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final _bloc = DisasterToolsBloc();

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
              buildDropButton(
                  value: _bloc.chosenValue,
                  items: _bloc.tools,
                  hint: "प्रकार निवडा",
                  onChanged: (String? value) {
                    setState(() {
                      _bloc.chosenValue = value;
                    });
                  }),
              spacer(),
              if (_bloc.chosenValue == "इतर")
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
        name: _bloc.chosenValue == "इतर"
            ? _nameController.text
            : _bloc.chosenValue,
        quantity: int.parse(_quantityController.text));

    BlocProvider.of<DisasterToolsBloc>(context).add(AddToolsData(_toolsData));
  }
}
