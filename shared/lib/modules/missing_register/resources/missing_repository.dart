import 'package:api/api.dart';
import 'package:shared/modules/missing_register/models/missing_model.dart';
import 'package:dio/dio.dart';

class MissingRepository {
  Future<dynamic> getMissingRegister() async {
    final response = await ApiSdk.getMissing();
    return response;
  }

  Future<dynamic> addMissingData({required MissingData missingData}) async {
    Map<String, dynamic> _body = missingData.toJson();
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postMissingRegister(body: _formData);
    return response;
  }
}
