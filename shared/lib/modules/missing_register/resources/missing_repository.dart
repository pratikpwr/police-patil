import 'package:api/api.dart';
import 'package:shared/modules/missing_register/models/missing_model.dart';
import 'package:dio/dio.dart';

class MissingRepository {
  Future<dynamic> getMissingRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getMissingByPP(userId: userId);
    return response;
  }

  Future<dynamic> addMissingData({required MissingData missingData}) async {
    Map<String, dynamic> _body = missingData.toJson();
    _body['aadhar'] = await MultipartFile.fromFile(_body['aadhar']);
    _body['photo'] = await MultipartFile.fromFile(_body['photo']);
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postMissingRegister(body: _formData);
    return response;
  }
}
