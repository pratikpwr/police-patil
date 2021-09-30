import 'package:api/api.dart';
import 'package:shared/modules/fire_register/models/fire_model.dart';

class FireRepository {
  Future<dynamic> getFireRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getFireByPP(userId: userId);
    return response;
  }

  Future<dynamic> addFireData({required FireData fireData}) async {
    final body = fireData.toJson();
    final response = await ApiSdk.postFireRegister(body: body);
    return response;
  }
}
