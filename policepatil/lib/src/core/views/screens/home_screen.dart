import 'package:flutter/material.dart';
import 'package:policepatil/src/core/views/screens/register_menu_screen.dart';

import '../../../features/certificates/presentation/police_patil_dakhala.dart';
import '../../../features/kayade/presentation/kayade_screen.dart';
import '../../../features/mandhan/presentation/mandhan_certificate_screen.dart';
import '../../../features/news/presentation/news_widget.dart';
import '../../config/constants.dart';
import '../../utils/custom_methods.dart';
import '../widgets/registers_button.dart';
import 'disaster_manage_menu.dart';

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
