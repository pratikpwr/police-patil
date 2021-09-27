export 'package:shared/modules/authentication/auth.dart';
export 'package:shared/modules/profile/profile.dart';
export 'package:shared/modules/arms_register/arms_register.dart';
export 'package:shared/modules/collection_register/collection_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> prefs = SharedPreferences.getInstance();
