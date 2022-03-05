import '../../../core/api/api.dart';
import 'package:dio/dio.dart';

import '../models/missing_model.dart';

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

  Future<dynamic> editMissingData({required MissingData missingData}) async {
    Map<String, dynamic> _body = missingData.toJson();
    _body['missingid'] = missingData.id;
    _body['_method'] = 'put';
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.editMissingRegister(body: _formData);
    return response;
  }

  Future<dynamic> deleteMissingData({required int id}) async {
    final _body = {'missingid': id, '_method': 'delete'};
    final response = await ApiSdk.deleteMissingRegister(body: _body);
    return response;
  }
}
