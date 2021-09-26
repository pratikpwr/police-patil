import 'package:api/api_constants.dart';
import 'package:api/shared_prefs/shared_prefs.dart';
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

  static Future<Response> getUserData({required int userId}) async {
    String path = ApiConstants.GET_USER_DATA + "$userId";

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }

  static Future<Response> updateUserData(
      {required int userId, required Map<String, dynamic> body}) async {
    String path = ApiConstants.UPDATE_USER_DATA + "$userId";

    Response response = await RestApiHandlerData.putData(path, body);
    return response;
  }

  // ARMS Register
  static Future<Response> postArmsRegister(
      {required Map<String, dynamic> body}) async {
    String path = ApiConstants.POST_ARMS_BY_PP;

    Response response = await RestApiHandlerData.putData(path, body);
    return response;
  }

  static Future<Response> getArmsByPP({required int userId}) async {
    String path = ApiConstants.GET_ARMS_BY_PP + "$userId";

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }
}
