import 'package:flutter/material.dart';
import 'package:policepatil/src/utils/utils.dart';

class HeadValueText extends StatelessWidget {
  const HeadValueText({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: Styles.titleTextStyle(),
        ),
        value.length < 35
            ? Text(
                value,
                style: Styles.subTitleTextStyle(),
              )
            : Text(
                "${value.substring(0, 35)} . . .",
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Styles.subTitleTextStyle(),
              )
      ],
    );
  }
}
