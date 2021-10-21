import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class DisasterRegFormScreen extends StatefulWidget {
  const DisasterRegFormScreen({Key? key}) : super(key: key);

  @override
  State<DisasterRegFormScreen> createState() => _DisasterRegFormScreenState();
}

class _DisasterRegFormScreenState extends State<DisasterRegFormScreen> {
  final _bloc = DisasterRegisterBloc();
  Position? _position;
  final TextEditingController _deathsController = TextEditingController();
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
                AttachButton(
                    text: SELECT_LOCATION,
                    icon: Icons.location_on_rounded,
                    onTap: () async {
                      _position = await determinePosition();
                      setState(() {
                        _bloc.longitude = _position!.longitude;
                        _bloc.latitude = _position!.latitude;
                      });
                    }),
                spacer(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("$LONGITUDE: ${_bloc.longitude}",
                        style: Styles.subTitleTextStyle()),
                    const SizedBox(width: 12),
                    Text("$LATITUDE: ${_bloc.latitude}",
                        style: Styles.subTitleTextStyle()),
                  ],
                ),
                spacer(),
                buildTextField(_levelController, "आपत्तीचे स्वरुप"),
                spacer(),
                buildTextField(_deathsController, "जिवितहानी संख्या"),
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
        latitude: _bloc.latitude,
        longitude: _bloc.longitude,
        date: _format.parse(_dateController.text),
        casuality: int.parse(_deathsController.text),
        level: _levelController.text);

    BlocProvider.of<DisasterRegisterBloc>(context)
        .add(AddDisasterData(_disasterData));
  }
}
