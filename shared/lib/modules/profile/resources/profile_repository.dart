import 'dart:io';

import 'package:api/api.dart';
import 'package:shared/shared.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  Future<dynamic> getUserData(int id) async {
    final response = await ApiSdk.getUserData(userId: id);
    return response;
  }

  Future<dynamic> updateUserData(int id, UserData user) async {
    final _body = user.toJson();
    _body['_method'] = 'put';
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.updateUserData(userId: id, body: _formData);
    return response;
  }
}
