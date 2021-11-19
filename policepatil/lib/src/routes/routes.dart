import 'package:flutter/material.dart';
import 'package:policepatil/src/views/views.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case '/home':
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case '/bottomNavBar':
      return MaterialPageRoute(builder: (_) => const BottomNavBar());
    case '/auth':
      return MaterialPageRoute(builder: (_) => const SignInScreen());
    case '/registers':
      return MaterialPageRoute(builder: (_) => const RegisterMenuScreen());
    case '/crime-registers':
      return MaterialPageRoute(builder: (_) => const CrimesRegMenuScreen());
    default:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}
