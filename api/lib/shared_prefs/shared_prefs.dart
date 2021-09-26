import 'package:api/shared_prefs/shared_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPrefs {
  static Future<bool> saveUserID(int userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(KEY_USER_ID, userID);
  }

  static Future<int?> getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(KEY_USER_ID);
  }

  static Future<bool> savePoliceStationID(int userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(KEY_POLICE_STATION_ID, userID);
  }

  static Future<int?> getPoliceStationID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(KEY_POLICE_STATION_ID);
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
