import 'package:api/api.dart';
import 'package:shared/modules/watch_register/models/watch_model.dart';
import 'package:dio/dio.dart';

class WatchRepository {
  Future<dynamic> getWatchRegister() async {
    final response = await ApiSdk.getWatch();
    return response;
  }

  Future<dynamic> addWatchData({required WatchData watchData}) async {
    Map<String, dynamic> _body = watchData.toJson();
    _body['aadhar'] = await MultipartFile.fromFile(_body['aadhar']);
    _body['photo'] = await MultipartFile.fromFile(_body['photo']);
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postWatchRegister(body: _formData);
    print(response.toString());
    return response;
  }
}
