import 'package:flutter/material.dart';

class Error404 extends StatelessWidget {
  const Error404({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Page Not Found. 404!'),
      ),
    );
  }
}
