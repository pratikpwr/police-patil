import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/custom_methods.dart';
import 'package:policepatil/src/views/views.dart';

class RegisterMenuScreen extends StatelessWidget {
  const RegisterMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          REGISTER,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
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
                      return const ArmsScreen();
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
