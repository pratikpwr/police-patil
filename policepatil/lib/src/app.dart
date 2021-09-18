import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/views/views.dart';
import 'package:shared/modules/auth/bloc/auth_bloc.dart';
import 'package:shared/modules/splash/bloc/splash_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => SplashBloc())
      ],
      child: const MaterialApp(
          title: STR_APP_NAME,
          debugShowCheckedModeBanner: false,
          home: RegisterScreen()),
    );
  }
}
