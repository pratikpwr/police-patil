import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';

class CrimesRegMenuScreen extends StatelessWidget {
  const CrimesRegMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(CRIMES_REGISTER),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          children: [
            RegistersButton(
              text: CRIMES,
              imageUrl: ImageConstants.IMG_CRIMES,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const CrimesScreen();
                }));
              },
            ),
            spacer(),
            RegistersButton(
              text: BURNS,
              imageUrl: ImageConstants.IMG_FIRE,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const FiresScreen();
                }));
              },
            ),
            spacer(),
            RegistersButton(
              text: DEATHS,
              imageUrl: ImageConstants.IMG_CRIMES_SUB,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const DeathScreen();
                }));
              },
            ),
            spacer(),
            RegistersButton(
              text: MISSING,
              imageUrl: ImageConstants.IMG_MISSING,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const MissingScreen();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
