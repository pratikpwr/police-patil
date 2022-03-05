import 'package:flutter/material.dart';

import '../../../features/arms_register/presentation/arms_screen.dart';
import '../../../features/collection_register/presentation/collect_screen.dart';
import '../../../features/illegal_register/presentation/illegal_works_screen.dart';
import '../../../features/movement_register/presentation/movement_screen.dart';
import '../../../features/public_place_register/presentation/social_places_screen.dart';
import '../../../features/watch_register/presentation/watch_screen.dart';
import '../../config/constants.dart';
import '../../utils/custom_methods.dart';
import '../widgets/registers_button.dart';
import 'crimes_menu_register.dart';

class RegisterMenuScreen extends StatelessWidget {
  const RegisterMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(REGISTER),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              spacer(),
              RegistersButton(
                  text: ARMS_COLLECTIONS,
                  imageUrl: ImageConstants.IMG_ARMS,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ArmsScreen();
                    }));
                  }),
              spacer(),
              RegistersButton(
                  text: COLLECTION_REGISTER,
                  imageUrl: ImageConstants.IMG_COLLECTION,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const CollectionScreen();
                    }));
                  }),
              spacer(),
              RegistersButton(
                  text: MOVEMENT_REGISTER,
                  imageUrl: ImageConstants.IMG_MOVEMENT,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const MovementScreen();
                    }));
                  }),
              spacer(),
              RegistersButton(
                  text: WATCH_REGISTER,
                  imageUrl: ImageConstants.IMG_WATCH,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const WatchScreen();
                    }));
                  }),
              spacer(),
              RegistersButton(
                  text: CRIMES_REGISTER,
                  imageUrl: ImageConstants.IMG_CRIMES,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const CrimesRegMenuScreen();
                    }));
                  }),
              spacer(),
              RegistersButton(
                  text: SOCIAL_PLACES,
                  imageUrl: ImageConstants.IMG_PLACES,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const SocialPlaceScreen();
                    }));
                  }),
              spacer(),
              RegistersButton(
                  text: ILLEGAL_WORKS,
                  imageUrl: ImageConstants.IMG_ILLEGAL,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const IllegalScreen();
                    }));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
