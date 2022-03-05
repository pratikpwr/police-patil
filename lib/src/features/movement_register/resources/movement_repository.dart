import '../../../core/api/api.dart';
import '../models/movement_model.dart';
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

  Future<dynamic> editMovementData({required MovementData movementData}) async {
    Map<String, dynamic> _body = movementData.toJson();
    _body['movementid'] = movementData.id;
    _body['_method'] = 'put';
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.editMovementRegister(body: _formData);
    return response;
  }

  Future<dynamic> deleteMovementData({required int id}) async {
    final _body = {'movementid': id, '_method': 'delete'};
    final response = await ApiSdk.deleteMovementRegister(body: _body);
    return response;
  }
}
