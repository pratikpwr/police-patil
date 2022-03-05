import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils/custom_methods.dart';
import '../../../core/views/widgets/custom_button.dart';
import '../../../core/views/widgets/custom_dropdown.dart';
import '../bloc/mandhan_bloc.dart';

class SelfCertificateScreen extends StatefulWidget {
  const SelfCertificateScreen({Key? key}) : super(key: key);

  @override
  State<SelfCertificateScreen> createState() => _SelfCertificateScreenState();
}

class _SelfCertificateScreenState extends State<SelfCertificateScreen> {
  final _bloc = MandhanBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("हजेरीबाबतचे स्वयंघोषणापत्र")),
      body: BlocListener<MandhanBloc, MandhanState>(
        listener: (context, state) {
          if (state is MandhanError) {
            showSnackBar(context, state.error);
          }
          if (state is MandhanSuccess) {
            try {
              launchUrl("https://${state.link}");
            } catch (e) {
              showSnackBar(context, SOMETHING_WENT_WRONG);
            }
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                spacer(),
                buildDropButton(
                    value: _bloc.chosenValue,
                    items: _bloc.meetingCount,
                    hint: "हजर असलेल्या बैठका",
                    onChanged: (String? value) {
                      setState(() {
                        _bloc.chosenValue = value;
                      });
                    }),
                spacer(),
                BlocBuilder<MandhanBloc, MandhanState>(
                  builder: (context, state) {
                    if (state is MandhanLoading) {
                      return const Loading();
                    }
                    return CustomButton(
                        text: "हजेरीबाबतचे स्वयंघोषणापत्र मिळवा",
                        onTap: () {
                          BlocProvider.of<MandhanBloc>(context).add(
                              GetMandhanDakhala(int.parse(_bloc.chosenValue!)));
                        });
                  },
                ),
                spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
