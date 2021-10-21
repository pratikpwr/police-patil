import 'package:api/api.dart';
import 'package:shared/modules/fire_register/models/fire_model.dart';
import 'package:dio/dio.dart';

class FireRepository {
  Future<dynamic> getFireRegister() async {
    final response = await ApiSdk.getFire();
    return response;
  }

  Future<dynamic> addFireData({required FireData fireData}) async {
    Map<String, dynamic> _body = fireData.toJson();
    _body['photo'] = await MultipartFile.fromFile(_body['photo']);
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postFireRegister(body: _formData);
    return response;
  }
}
