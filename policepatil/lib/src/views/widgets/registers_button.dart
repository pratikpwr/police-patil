import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';

class RegistersButton extends StatelessWidget {
  final String text;
  final String? imageUrl;
  final VoidCallback onTap;

  const RegistersButton(
      {Key? key, required this.text, this.imageUrl, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.93,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              primary: CONTAINER_BACKGROUND_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                imageUrl!,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                text,
                style:
                    Styles.appBarTextStyle(color: REGISTER_BUTTON_TEXT_COLOR),
              ),
            ],
          )),
    );
  }
}
