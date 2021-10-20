import 'package:flutter/material.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';

import '../../views.dart';

class MandhanScreen extends StatelessWidget {
  const MandhanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(MANDHAN)),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              spacer(),
              RegistersButton(
                  text: "हजेरीबाबतचे स्वयंघोषणापत्र",
                  imageUrl: ImageConstants.IMG_CERTIFICATE,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return SelfCertificateScreen();
                    }));
                  }),
              spacer(),
              RegistersButton(
                  text: "पो. पाटील बैठक",
                  imageUrl: ImageConstants.IMG_MEETING,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const MeetingsScreen();
                    }));
                  }),
              spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
