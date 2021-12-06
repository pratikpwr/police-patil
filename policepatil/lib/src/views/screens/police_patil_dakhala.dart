import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/shared.dart';

class PatilCertificate extends StatefulWidget {
  const PatilCertificate({Key? key}) : super(key: key);

  @override
  State<PatilCertificate> createState() => _PatilCertificateState();
}

class _PatilCertificateState extends State<PatilCertificate> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  String? gender;
  final List<String> genderTypes = <String>["पुरुष", "स्त्री", "इतर"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("पोलीस पाटील दाखला")),
      body: BlocListener<CertificatesBloc, CertificatesState>(
        listener: (context, state) {
          if (state is CertificatesError) {
            showSnackBar(context, state.error);
          }
          if (state is CertificatesSuccess) {
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
                buildTextField(_nameController, NAME),
                spacer(),
                buildTextField(_ageController, AGE),
                spacer(),
                buildDropButton(
                    value: gender,
                    items: genderTypes,
                    hint: "लिंग निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        gender = value;
                      });
                    }),
                spacer(),
                BlocBuilder<CertificatesBloc, CertificatesState>(
                  builder: (context, state) {
                    if (state is CertificatesLoading) {
                      return const Loading();
                    }
                    return CustomButton(
                        text: "पोलीस पाटील दाखला मिळवा",
                        onTap: () {
                          BlocProvider.of<CertificatesBloc>(context).add(
                              GetCertificatesDakhala(
                                  name: _nameController.text,
                                  gender: gender ?? "-",
                                  age: _ageController.text));
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
