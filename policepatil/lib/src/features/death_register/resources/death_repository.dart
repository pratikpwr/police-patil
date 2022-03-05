import 'package:dio/dio.dart';

import '../../../core/api/api.dart';
import '../models/death_model.dart';

class DeathRepository {
  Future<dynamic> getDeathRegister() async {
    final response = await ApiSdk.getDeath();
    return response;
  }

  Future<dynamic> addDeathData({required DeathData deathData}) async {
    Map<String, dynamic> _body = deathData.toJson();
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postDeathRegister(body: _formData);
    return response;
  }

  Future<dynamic> editDeathData({required DeathData deathData}) async {
    Map<String, dynamic> _body = deathData.toJson();
    _body['deathid'] = deathData.id;
    _body['_method'] = 'put';
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.editDeathRegister(body: _formData);
    return response;
  }

  Future<dynamic> deleteDeathData({required int id}) async {
    final _body = {'deathid': id, '_method': 'delete'};
    final response = await ApiSdk.deleteDeathRegister(body: _body);
    return response;
  }
}
