import 'package:dio/dio.dart';

import '../../../core/api/api.dart';
import '../models/arms_model.dart';

class ArmsRepository {
  Future<dynamic> getArmsRegister() async {
    final response = await ApiSdk.getArms();
    return response;
  }

  Future<dynamic> addArmsData({required ArmsData armsData}) async {
    Map<String, dynamic> _body = armsData.toJson();
    // _body['aadhar'] = await MultipartFile.fromFile(_body['aadhar']);
    // _body['licencephoto'] = await MultipartFile.fromFile(_body['licencephoto']);
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postArmsRegister(body: _formData);
    return response;
  }

  Future<dynamic> editArmsData({required ArmsData armsData}) async {
    Map<String, dynamic> _body = armsData.toJson();
    _body['armsid'] = armsData.id;
    _body['_method'] = 'put';
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.editArmsRegister(body: _formData);
    return response;
  }

  Future<dynamic> deleteArmsData({required int id}) async {
    final _body = {'armsid': id, '_method': 'delete'};
    final response = await ApiSdk.deleteArmsRegister(body: _body);
    return response;
  }
}
