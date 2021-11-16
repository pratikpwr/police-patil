import 'package:api/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:api/rest/rest_api_handler_data.dart';

class ApiSdk {
  // AUTH

  // static Future<Response> signUp({required String mobileNo}) async {
  //   // sends OTP
  //   String path = '${ApiConstants.SEND_OTP}' + mobileNo;
  //   Response response = await RestApiHandlerData.getData(path);
  //   return response;
  // }

  static Future<Response> loginWithEmailAndPassword(
      {required userAuthData}) async {
    String path = ApiConstants.LOGIN;

    Map<String, dynamic> body = userAuthData;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> appVersion() async {
    String path = ApiConstants.GET_APP_VERSION;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> getUserData({required int userId}) async {
    String path = ApiConstants.GET_USER_DATA + "$userId";

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> updateUserData(
      {required int userId, required dynamic body}) async {
    String path = ApiConstants.UPDATE_USER_DATA + "$userId";

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> updateDangerZoneData(
      {required int userId, required dynamic body}) async {
    String path = ApiConstants.UPDATE_USER_DATA + "$userId";

    Response response = await RestApiHandlerData.putData(path, body);
    return response;
  }

  static Future<Response> getPoliceStation() async {
    String path = ApiConstants.POLICE_STATION;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> getVillages() async {
    String path = ApiConstants.VILLAGE_LIST;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  // ARMS Register
  static Future<Response> postArmsRegister({required body}) async {
    String path = ApiConstants.POST_ARMS_BY_PP;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getArmsByPP({required int userId}) async {
    String path = ApiConstants.GET_ARMS_BY_PP + "$userId";

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> editArmsRegister({required body}) async {
    String path = ApiConstants.POST_ARMS_BY_PP + '/edit';

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> deleteArmsRegister({required body}) async {
    String path = ApiConstants.POST_ARMS_BY_PP + '/delete';

    Response response = await RestApiHandlerData.deleteData(path, body: body);
    return response;
  }

  static Future<Response> getArms() async {
    String path = ApiConstants.GET_ARMS;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  // Collect Register
  static Future<Response> postCollectRegister({required dynamic body}) async {
    String path = ApiConstants.POST_COLLECT_BY_PP;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getCollect() async {
    String path = ApiConstants.GET_COLLECT;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  // Movement Register
  static Future<Response> postMovementRegister({required body}) async {
    String path = ApiConstants.POST_MOVEMENT_BY_PP;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getMovement() async {
    String path = ApiConstants.GET_MOVEMENT;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  //  Register
  static Future<Response> postWatchRegister({required body}) async {
    String path = ApiConstants.POST_WATCH_BY_PP;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getWatch({String? params}) async {
    String path = "${ApiConstants.GET_WATCH}${params ?? ""}";

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  //  Register
  static Future<Response> postCrimeRegister({required body}) async {
    String path = ApiConstants.POST_CRIME_BY_PP;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getCrime() async {
    String path = ApiConstants.GET_CRIME;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  //  Register
  static Future<Response> postFireRegister({required body}) async {
    String path = ApiConstants.POST_FIRE_BY_PP;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getFire() async {
    String path = ApiConstants.GET_FIRE;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  //  Register
  static Future<Response> postDeathRegister({required body}) async {
    String path = ApiConstants.POST_DEATH_BY_PP;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getDeath() async {
    String path = ApiConstants.GET_DEATH;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  //  Register
  static Future<Response> postMissingRegister({required body}) async {
    String path = ApiConstants.POST_MISSING_BY_PP;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getMissing() async {
    String path = ApiConstants.GET_MISSING;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  //  Register
  static Future<Response> postPlaceRegister({required body}) async {
    String path = ApiConstants.POST_PUBLIC_PLACE_BY_PP;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getPlace() async {
    String path = ApiConstants.GET_PUBLIC_PLACE;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  //  Register
  static Future<Response> postIllegalRegister({required body}) async {
    String path = ApiConstants.POST_ILLEGAL_WORK_BY_PP;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getIllegal() async {
    String path = ApiConstants.GET_ILLEGAL_WORK;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> postDisasterHelper({required body}) async {
    String path = ApiConstants.DISASTER_HELPER;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getDisasterHelper() async {
    String path = ApiConstants.DISASTER_HELPER;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> postVillageSafety({required body}) async {
    String path = ApiConstants.VILLAGE_HELPER;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getVillageSafety() async {
    String path = ApiConstants.VILLAGE_HELPER;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> postDisasterTools({required body}) async {
    String path = ApiConstants.DISASTER_TOOLS;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getDisasterTools() async {
    String path = ApiConstants.DISASTER_TOOLS;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> postDisasterRegister({required body}) async {
    String path = ApiConstants.DISASTER;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getDisaster() async {
    String path = ApiConstants.DISASTER;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> getNews() async {
    String path = ApiConstants.GET_NEWS;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> getTopNews() async {
    String path = ApiConstants.GET_TOP_NEWS;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> getAlerts() async {
    String path = ApiConstants.GET_ALERTS;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> getKayade() async {
    String path = ApiConstants.GET_KAYADE;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> getDangerArea() async {
    String path = ApiConstants.GET_DANGER_AREA;

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> getCertificate({required body}) async {
    String path = ApiConstants.GET_CERTIFICATE;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }

  static Future<Response> getMandhan({required body}) async {
    String path = ApiConstants.GET_MANDHAN;

    Response response = await RestApiHandlerData.postData(path, body);
    return response;
  }
}
