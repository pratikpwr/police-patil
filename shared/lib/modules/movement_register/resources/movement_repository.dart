import 'package:api/api.dart';
import 'package:shared/modules/movement_register/models/movement_model.dart';
import 'package:dio/dio.dart';

class MovementRepository {
  Future<dynamic> getMovementRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getMovementByPP(userId: userId);
    return response;
  }

  Future<dynamic> addMovementData({required MovementData movementData}) async {
    Map<String, dynamic> _body = movementData.toJson();
    _body['photo'] = await MultipartFile.fromFile(_body['photo']);
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postMovementRegister(body: _formData);
    return response;
  }
}
