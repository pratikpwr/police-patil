import 'package:flutter/material.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:policepatil/src/views/screens/kayade_screen.dart';
import 'package:policepatil/src/views/views.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(POLICE_PATIL_APP),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  spacer(height: 8),
                  const ImpNewsWidget(),
                  spacer(),
                  RegistersButton(
                      text: REGISTER,
                      imageUrl: ImageConstants.IMG_PLACEHOLDER,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const RegisterMenuScreen();
                        }));
                      }),
                  spacer(),
                  RegistersButton(
                      text: "हजेरीबाबतचे स्वयंघोषणापत्र",
                      imageUrl: ImageConstants.IMG_MONEY,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const SelfCertificateScreen();
                        }));
                      }),
                  spacer(),
                  RegistersButton(
                      text: "पोलीस पाटील दाखला",
                      imageUrl: ImageConstants.IMG_CERTIFICATE,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const PatilCertificate();
                        }));
                      }),
                  spacer(),
                  RegistersButton(
                      text: LAWS,
                      imageUrl: ImageConstants.IMG_HAMMER,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const KayadeScreen();
                        }));
                      }),
                  spacer(),
                  RegistersButton(
                      text: DISASTER_MANAGEMENT,
                      imageUrl: ImageConstants.IMG_DISASTER,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const DisasterMenuScreen();
                        }));
                      }),
                  spacer()
                ],
              ))),
    );
  }
}
