import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/config/image_constants.dart';
import 'package:policepatil/src/views/views.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: LogoWidget(logoSize: 100),
          ),
          DrawerListTile(
            title: ARMS_COLLECTIONS,
            imageUrl: ImageConstants.IMG_ARMS,
            press: () {},
          ),
          const Divider(),
          DrawerListTile(
            title: COLLECTION_REGISTER,
            imageUrl: ImageConstants.IMG_COLLECTION,
            press: () {},
          ),
          const Divider(),
          DrawerListTile(
            title: MOVEMENT_REGISTER,
            imageUrl: ImageConstants.IMG_MOVEMENT,
            press: () {},
          ),
          const Divider(),
          DrawerListTile(
            title: WATCH_REGISTER,
            imageUrl: ImageConstants.IMG_WATCH,
            press: () {},
          ),
          const Divider(),
          DrawerListTile(
            title: CRIMES_REGISTER,
            imageUrl: ImageConstants.IMG_CRIMES,
            press: () {},
          ),
          const Divider(),
          DrawerListTile(
            title: SOCIAL_PLACES,
            imageUrl: ImageConstants.IMG_PLACES,
            press: () {},
          ),
          const Divider(),
          DrawerListTile(
            title: ILLEGAL_WORKS,
            imageUrl: ImageConstants.IMG_ILLEGAL,
            press: () {},
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.imageUrl,
    required this.press,
  }) : super(key: key);

  final String title, imageUrl;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 8.0,
      leading: Image.asset(
        imageUrl,
        height: 36,
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.black87,
        ),
      ),
    );
  }
}
