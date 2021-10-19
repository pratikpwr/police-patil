import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/views/views.dart';
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
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            final _size = MediaQuery.of(context).size;
            return Stack(
              children: [
                Image.asset(
                  ImageConstants.IMG_SHAPES_1,
                  height: _size.height,
                  width: _size.width,
                  fit: BoxFit.fill,
                ),
                Container(
                    height: _size.height,
                    width: _size.width,
                    alignment: Alignment.center,
                    child: const LogoWidget(logoSize: 250)),
              ],
            );
          }),
    ));
  }
}
