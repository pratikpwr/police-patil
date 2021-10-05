import 'package:api/api.dart';
import 'package:shared/shared.dart';
import 'package:dio/dio.dart';

class ArmsRepository {
  Future<dynamic> getArmsRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getArmsByPP(userId: userId);
    return response;
  }

  Future<dynamic> addArmsData({required ArmsData armsData}) async {
    Map<String, dynamic> _body = armsData.toJson();
    _body['aadhar'] = await MultipartFile.fromFile(_body['aadhar']);
    _body['licencephoto'] = await MultipartFile.fromFile(_body['licencephoto']);
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postArmsRegister(body: _formData);
    return response;
  }
}
