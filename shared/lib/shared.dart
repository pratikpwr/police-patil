export 'package:shared/modules/authentication/auth.dart';
export 'package:shared/modules/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> prefs = SharedPreferences.getInstance();
