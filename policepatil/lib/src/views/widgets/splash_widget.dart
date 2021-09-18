import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/modules/splash/bloc/splash_bloc.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
    _dispatchEvent();
  }

  _dispatchEvent() {
    BlocProvider.of<SplashBloc>(context).add(NavigateToHome());
  }

  @override
  Widget build(BuildContext context) {
    return const LogoWidget();
  }
}
