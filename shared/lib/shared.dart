export 'package:shared/modules/authentication/auth.dart';
export 'package:shared/modules/profile/profile.dart';
export 'package:shared/modules/arms_register/arms_register.dart';
export 'package:shared/modules/collection_register/collection_register.dart';
export 'package:shared/modules/public_place_register/public_place_register.dart';
export 'package:shared/modules/missing_register/missing_register.dart';
export 'package:shared/modules/fire_register/fire_register.dart';
export 'package:shared/modules/death_register/death_register.dart';
export 'package:shared/modules/crime_register/crime_register.dart';
export 'package:shared/modules/watch_register/watch_register.dart';
export 'package:shared/modules/illegal_register/illegal_register.dart';
export 'package:shared/modules/movement_register/movement_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> prefs = SharedPreferences.getInstance();
