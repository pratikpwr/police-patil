import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/alert_wall/bloc/alert_bloc.dart';
import '../../features/app_version/bloc/app_version_bloc.dart';
import '../../features/arms_register/bloc/arms_register_bloc.dart';
import '../../features/authentication/bloc/authentication_bloc.dart';
import '../../features/certificates/bloc/certificates_bloc.dart';
import '../../features/collection_register/bloc/collect_register_bloc.dart';
import '../../features/crime_register/bloc/crime_register_bloc.dart';
import '../../features/death_register/bloc/death_register_bloc.dart';
import '../../features/disaster_helper/bloc/disaster_helper_bloc.dart';
import '../../features/disaster_register/bloc/disaster_register_bloc.dart';
import '../../features/disaster_tools/bloc/disaster_tools_bloc.dart';
import '../../features/fire_register/bloc/fire_register_bloc.dart';
import '../../features/illegal_register/bloc/illegal_register_bloc.dart';
import '../../features/kayade/bloc/kayade_bloc.dart';
import '../../features/mandhan/bloc/mandhan_bloc.dart';
import '../../features/missing_register/bloc/missing_register_bloc.dart';
import '../../features/movement_register/bloc/movement_register_bloc.dart';
import '../../features/news/bloc/news_bloc.dart';
import '../../features/profile/bloc/profile_bloc.dart';
import '../../features/public_place_register/bloc/public_place_register_bloc.dart';
import '../../features/village_ps_list/bloc/village_pslist_bloc.dart';
import '../../features/village_safety/bloc/village_safety_bloc.dart';
import '../../features/watch_register/bloc/watch_register_bloc.dart';

List<BlocProvider> getAppBlocProviders() => [
      BlocProvider(create: (ctx) => AuthenticationBloc()),
      BlocProvider(create: (ctx) => AppVersionBloc()),
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
      BlocProvider(create: (context) => VillagePSListBloc()),
      BlocProvider(create: (ctx) => CertificatesBloc()),
    ];
