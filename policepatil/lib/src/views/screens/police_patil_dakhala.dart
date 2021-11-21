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

  final _bloc = CertificatesBloc();
  final _nameController = TextEditingController();
  final _casteController = TextEditingController();

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
            launchUrl("https://${state.link}");
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
                buildTextField(_casteController, "जात"),
                spacer(),
                buildDropButton(
                    value: _bloc.gender,
                    items: _bloc.genderTypes,
                    hint: "लिंग निवडा",
                    onChanged: (String? value) {
                      setState(() {
                        _bloc.gender = value;
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
                          _bloc.body["gender"] = _bloc.gender;
                          _bloc.body["name"] = _nameController.text;
                          _bloc.body["caste"] = _casteController.text;
                          BlocProvider.of<CertificatesBloc>(context)
                              .add(GetCertificatesDakhala());
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
