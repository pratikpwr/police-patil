import 'package:flutter/material.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';

import '../../views.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({Key? key}) : super(key: key);

  @override
  State<MeetingsScreen> createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  String? _chosenValue;

  final List<String> _meetingCount = <String>["0", "1", "2", "3", "4", "5"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("पो. पाटील बैठक")),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              spacer(),
              buildDropButton(
                  value: _chosenValue,
                  items: _meetingCount,
                  hint: "हजर असलेल्या बैठका",
                  onChanged: (String? value) {
                    setState(() {
                      _chosenValue = value;
                    });
                  }),
              spacer(),
              CustomButton(
                  text: REGISTER,
                  onTap: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
