import 'package:flutter/material.dart';

import '../../../features/crime_register/presentation/crimes_screen.dart';
import '../../../features/death_register/presentation/death_screen.dart';
import '../../../features/fire_register/presentation/fires_screen.dart';
import '../../../features/missing_register/presentation/missing_screen.dart';
import '../../config/constants.dart';
import '../../utils/custom_methods.dart';
import '../widgets/registers_button.dart';

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
