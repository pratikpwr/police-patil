import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/modules/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildBody(context)));
  }

  BlocProvider<SplashBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Center(
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              if ((state is SplashInitial) || (state is SplashLoading)) {
                return const SplashWidget();
              } else {
                return const HomeScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
