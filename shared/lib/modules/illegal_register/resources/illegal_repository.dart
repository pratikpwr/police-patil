import 'package:api/api.dart';
import 'package:shared/modules/illegal_register/models/illegal_model.dart';
import 'package:dio/dio.dart';

class IllegalRepository {
  Future<dynamic> getIllegalRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getIllegalByPP(userId: userId);
    return response;
  }

  Future<dynamic> addIllegalData({required IllegalData illegalData}) async {
    Map<String, dynamic> _body = illegalData.toJson();
    _body['photo'] = await MultipartFile.fromFile(_body['photo']);
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postIllegalRegister(body: _formData);
    return response;
  }
}
