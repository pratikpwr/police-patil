import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/views/views.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
              _spacer(),
              RegistersButton(
                  text: WATCH_REGISTER,
                  imageUrl: ImageConstants.IMG_WATCH,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const WatchRegScreen();
                    }));
                  }),
              _spacer(),
              RegistersButton(
                  text: MOVEMENT_REGISTER,
                  imageUrl: ImageConstants.IMG_MOVEMENT,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const MovementRegScreen();
                    }));
                  }),
              _spacer(),
              RegistersButton(
                  text: COLLECTION_REGISTER,
                  imageUrl: ImageConstants.IMG_COLLECTION,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const CollectRegScreen();
                    }));
                  }),
              _spacer(),
              RegistersButton(
                  text: ARMS_COLLECTIONS,
                  imageUrl: ImageConstants.IMG_ARMS,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const ArmsRegScreen();
                    }));
                  }),
              _spacer(),
              RegistersButton(
                  text: CRIMES_REGISTER,
                  imageUrl: ImageConstants.IMG_CRIMES,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const CrimesRegScreen();
                    }));
                  }),
              _spacer(),
              RegistersButton(
                  text: SOCIAL_PLACES,
                  imageUrl: ImageConstants.IMG_PLACES,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const SocialPlacesRegScreen();
                    }));
                  }),
              _spacer(),
              RegistersButton(
                  text: ILLEGAL_WORKS,
                  imageUrl: ImageConstants.IMG_ILLEGAL,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const IllegalWorksScreen();
                    }));
                  }),
              _spacer(),
              RegistersButton(
                  text: DISASTER_MANAGEMENT,
                  imageUrl: ImageConstants.IMG_DISASTER,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const DisasterRegScreen();
                    }));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _spacer() {
    return const SizedBox(
      height: 16,
    );
  }
}
