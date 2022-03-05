import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils/custom_methods.dart';
import '../../../core/utils/styles.dart';
import '../../../core/views/widgets/custom_button.dart';
import '../bloc/disaster_register_bloc.dart';

class DisasterAreaAddForm extends StatefulWidget {
  const DisasterAreaAddForm({Key? key}) : super(key: key);

  @override
  _DisasterAreaAddFormState createState() => _DisasterAreaAddFormState();
}

class _DisasterAreaAddFormState extends State<DisasterAreaAddForm> {
  final _bloc = DisasterRegisterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("आपत्ती प्रवण क्षेत्र")),
      body: BlocListener<DisasterRegisterBloc, DisasterRegisterState>(
        listener: (context, state) {
          if (state is DisasterAreaSendError) {
            showSnackBar(context, state.error);
          }
          if (state is DisasterAreaSent) {
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
              Text(
                "तुमचे गाव कोणत्या आपत्ती प्रवण क्षेत्रात येते ?",
                style: Styles.titleTextStyle(fontSize: 18),
              ),
              spacer(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _bloc.areas.length,
                itemBuilder: (context, index) {
                  final curArea = _bloc.areas[index];
                  return CheckboxListTile(
                      title: Text(
                        curArea.title,
                        style: Styles.titleTextStyle(),
                      ),
                      value: curArea.isSelected,
                      activeColor: PRIMARY_COLOR,
                      onChanged: (value) {
                        setState(() {
                          curArea.isSelected = value!;
                        });
                        if (value!) {
                          _bloc.selectedAreas.add(curArea.title);
                        } else {
                          _bloc.selectedAreas.add(curArea.title);
                        }
                      });
                },
              ),
              spacer(),
              CustomButton(
                  text: DO_REGISTER,
                  onTap: () {
                    BlocProvider.of<DisasterRegisterBloc>(context)
                        .add(AddDisasterArea(_bloc.selectedAreas));
                  })
            ],
          ),
        )),
      ),
    );
  }
}
