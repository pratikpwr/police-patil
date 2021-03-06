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
export 'package:shared/modules/news/news.dart';
export 'package:shared/modules/alert_wall/alert.dart';
export 'package:shared/modules/disaster_helper/disaster_helper.dart';
export 'package:shared/modules/disaster_tools/disaster_tools.dart';
export 'package:shared/modules/disaster_register/disaster_register.dart';
export 'package:shared/modules/kayade/kayade.dart';
export 'package:shared/modules/village_safety/village_safety.dart';
export 'package:shared/modules/certificates/certificates.dart';
export 'package:shared/modules/mandhan/mandhan.dart';
export 'package:shared/modules/app_version/app_version.dart';
export 'package:shared/modules/village_ps_list/village_ps_list.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> prefs = SharedPreferences.getInstance();
DateFormat dateFormat = DateFormat("yyyy-MM-dd");
