import 'package:api/api.dart';
import 'package:shared/modules/movement_register/models/movement_model.dart';
import 'package:dio/dio.dart';

class MovementRepository {
  Future<dynamic> getMovementRegister() async {
    final response = await ApiSdk.getMovement();
    return response;
  }

  Future<dynamic> addMovementData({required MovementData movementData}) async {
    Map<String, dynamic> _body = movementData.toJson();
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postMovementRegister(body: _formData);
    return response;
  }
}
