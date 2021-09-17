import 'package:api/shared_prefs/shared_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPrefs {
  static Future<bool> saveUserID(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(KEY_USER_ID, userID);
  }

  static Future<String?> getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_USER_ID);
  }

  static Future<bool> saveToken(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(KEY_TOKEN, userID);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_TOKEN);
  }
}
