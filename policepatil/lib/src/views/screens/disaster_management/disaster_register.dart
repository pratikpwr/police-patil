import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _bloc = DisasterRegisterBloc();
  final TextEditingController _casualityController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(REGISTER_DISASTER)),
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
                    value: _bloc.chosenType,
                    items: _bloc.disasterTypes,
                    hint: "आपत्ती प्रकार निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        _bloc.chosenType = value;
                        _bloc.subTypes = _bloc.getSubType();
                        _bloc.chosenSubType = null;
                      });
                    }),
                spacer(),
                _bloc.chosenType != null
                    ? buildDropButton(
                        value: _bloc.chosenSubType,
                        items: _bloc.subTypes!,
                        hint: "आपत्ती उपप्रकार निवडा",
                        onChanged: (String? value) {
                          setState(() {
                            _bloc.chosenSubType = value;
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
        type: _bloc.chosenType,
        subtype: _bloc.chosenSubType,
        date: _format.parse(_dateController.text),
        casuality: int.parse(_casualityController.text),
        level: _levelController.text);

    BlocProvider.of<DisasterRegisterBloc>(context)
        .add(AddDisasterData(_disasterData));
  }
}
