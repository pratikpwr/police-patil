import 'package:api/api.dart';
import 'package:shared/modules/death_register/models/death_model.dart';

class DeathRepository {
  Future<dynamic> getDeathRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getDeathByPP(userId: userId);
    return response;
  }

  Future<dynamic> addDeathData({required DeathData deathData}) async {
    final body = deathData.toJson();
    final response = await ApiSdk.postDeathRegister(body: body);
    return response;
  }
}
