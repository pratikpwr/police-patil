import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/config/theme_data.dart';
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
        BlocProvider(create: (ctx) => ArmsRegisterBloc()),
        BlocProvider(create: (ctx) => CollectRegisterBloc()),
        BlocProvider(create: (ctx) => MovementRegisterBloc()),
        BlocProvider(create: (ctx) => WatchRegisterBloc()),
        BlocProvider(create: (ctx) => CrimeRegisterBloc()),
        BlocProvider(create: (ctx) => DeathRegisterBloc()),
        BlocProvider(create: (ctx) => FireRegisterBloc()),
        BlocProvider(create: (ctx) => MissingRegisterBloc()),
        BlocProvider(create: (ctx) => PublicPlaceRegisterBloc()),
        BlocProvider(create: (ctx) => IllegalRegisterBloc()),
        BlocProvider(create: (ctx) => AlertBloc()),
        BlocProvider(create: (ctx) => KayadeBloc()),
        BlocProvider(create: (ctx) => DisasterRegisterBloc()),
        BlocProvider(create: (ctx) => DisasterHelperBloc()),
        BlocProvider(create: (ctx) => DisasterToolsBloc()),
        BlocProvider(create: (ctx) => VillageSafetyBloc()),
        BlocProvider(create: (ctx) => MandhanBloc()),
        BlocProvider(create: (context) => NewsBloc()),
        BlocProvider(create: (ctx) => CertificatesBloc()),
      ],
      child: MaterialApp(
          title: STR_APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: myTheme,
          onGenerateRoute: routes),
    );
  }
}
