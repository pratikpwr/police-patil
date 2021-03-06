import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/views/screens/app_update.dart';
import 'package:shared/shared.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    authenticationBloc = AuthenticationBlocController().authenticationBloc;
    authenticationBloc.add(AppLoadedUp());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
            bloc: authenticationBloc,
            listener: (BuildContext context, AuthenticationState state) {
              if (state is AppAuthenticated) {
                Navigator.pushNamed(context, '/bottomNavBar');
              }
              if (state is AuthenticationStart) {
                Navigator.pushNamed(context, '/auth');
              }
              if (state is UserLogoutState) {
                Navigator.pushNamed(context, '/auth');
              }
            },
            child: const SizedBox()));
  }
}
