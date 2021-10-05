import 'package:api/api.dart';
import 'package:shared/modules/watch_register/models/watch_model.dart';
import 'package:dio/dio.dart';

class WatchRepository {
  Future<dynamic> getWatchRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getWatchByPP(userId: userId);
    return response;
  }

  Future<dynamic> addWatchData({required WatchData watchData}) async {
    Map<String, dynamic> _body = watchData.toJson();
    _body['aadhar'] = await MultipartFile.fromFile(_body['aadhar']);
    _body['otherphoto'] = await MultipartFile.fromFile(_body['otherphoto']);
    _body['photo'] = await MultipartFile.fromFile(_body['photo']);
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postWatchRegister(body: _formData);
    print(response.toString());
    return response;
  }
}
