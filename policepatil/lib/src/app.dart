import 'package:flutter/material.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/views/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: AppName,
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
