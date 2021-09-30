import 'package:api/api.dart';
import 'package:shared/modules/movement_register/models/movement_model.dart';

class MovementRepository {
  Future<dynamic> getMovementRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getMovementByPP(userId: userId);
    return response;
  }

  Future<dynamic> addMovementData({required MovementData movementData}) async {
    final body = movementData.toJson();
    final response = await ApiSdk.postMovementRegister(body: body);
    return response;
  }
}
