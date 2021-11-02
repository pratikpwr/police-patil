import 'package:api/api.dart';
import 'package:shared/modules/death_register/models/death_model.dart';
import 'package:dio/dio.dart';

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
}
