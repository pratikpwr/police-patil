import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/routes/routes.dart';
import 'package:shared/shared.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => AuthenticationBloc()),
        BlocProvider(create: (ctx) => ProfileBloc()),
      ],
      child: const MaterialApp(
          title: STR_APP_NAME,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: routes),
    );
  }
}

// TODO : Change com.dcdevelopers.policepatil to  com.punerural.policepatil
