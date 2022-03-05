import 'package:dio/dio.dart';

import '../../../core/api/api.dart';
import '../models/fire_model.dart';

class FireRepository {
  Future<dynamic> getFireRegister() async {
    final response = await ApiSdk.getFire();
    return response;
  }

  Future<dynamic> addFireData({required FireData fireData}) async {
    Map<String, dynamic> _body = fireData.toJson();
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postFireRegister(body: _formData);
    return response;
  }

  Future<dynamic> editFireData({required FireData fireData}) async {
    Map<String, dynamic> _body = fireData.toJson();
    _body['fireid'] = fireData.id;
    _body['_method'] = 'put';
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.editFireRegister(body: _formData);
    return response;
  }

  Future<dynamic> deleteFireData({required int id}) async {
    final _body = {'fireid': id, '_method': 'delete'};
    final response = await ApiSdk.deleteFireRegister(body: _body);
    return response;
  }
}
