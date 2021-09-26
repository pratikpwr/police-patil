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

  static Future<Response> getUserData({required int userId}) async {
    String path = ApiConstants.GET_USER_DATA + "$userId";

    Response response = await RestApiHandlerData.getData(path);
    return response;
  }
}
