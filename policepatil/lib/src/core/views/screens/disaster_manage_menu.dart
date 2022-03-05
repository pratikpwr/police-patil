import 'package:flutter/material.dart';

import '../../../features/disaster_helper/presentation/disaster_helper_screen.dart';
import '../../../features/disaster_register/presentation/disaster_area_screen.dart';
import '../../../features/disaster_register/presentation/disaster_register_screen.dart';
import '../../../features/disaster_tools/presentation/disaster_tools_screen.dart';
import '../../../features/village_safety/presentation/village_safety_screen.dart';
import '../../config/constants.dart';
import '../../utils/custom_methods.dart';
import '../widgets/registers_button.dart';

class DisasterMenuScreen extends StatelessWidget {
  const DisasterMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(DISASTER_MANAGEMENT)),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            spacer(),
            RegistersButton(
                text: "आपत्ती प्रवण क्षेत्र",
                imageUrl: ImageConstants.IMG_DISASTER_MANAGE,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const DisasterAreaScreen();
                  }));
                }),
            spacer(),
            RegistersButton(
                text: REGISTER_DISASTER,
                imageUrl: ImageConstants.IMG_DISASTER_MANAGE,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const DisasterRegScreen();
                  }));
                }),
            spacer(),
            RegistersButton(
                text: DISASTER_HELPER,
                imageUrl: ImageConstants.IMG_DISASTER_HELPER,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const DisasterManageHelperScreen();
                  }));
                }),
            spacer(),
            RegistersButton(
                text: VILLAGE_SAFETY,
                imageUrl: ImageConstants.IMG_DISASTER_HELPER,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const VillageSafetyScreen();
                  }));
                }),
            spacer(),
            RegistersButton(
                text: DISASTER_TOOLS,
                imageUrl: ImageConstants.IMG_DISASTER_TOOLS,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const DisasterManageToolsScreen();
                  }));
                }),
            spacer(),
          ],
        ),
      ),
    );
  }
}
