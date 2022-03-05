import 'package:flutter/material.dart';

import '../../features/authentication/presentation/sign_in_screen.dart';
import '../views/screens/bottom_nav_bar.dart';
import '../views/screens/crimes_menu_register.dart';
import '../views/screens/home_screen.dart';
import '../views/screens/register_menu_screen.dart';
import '../views/screens/splash_screen.dart';

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
