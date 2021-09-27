import 'package:api/api.dart';
import 'package:shared/shared.dart';

class ArmsRepository {
  Future<dynamic> getArmsRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getArmsByPP(userId: userId);
    return response;
  }

  Future<dynamic> addArmsData({required ArmsData armsData}) async {
    final body = armsData.toJson();
    final response = await ApiSdk.postArmsRegister(body: body);
    return response;
  }
}
