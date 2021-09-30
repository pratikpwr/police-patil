import 'package:api/api.dart';
import 'package:shared/modules/illegal_register/models/illegal_model.dart';

class IllegalRepository {
  Future<dynamic> getIllegalRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getIllegalByPP(userId: userId);
    return response;
  }

  Future<dynamic> addIllegalData({required IllegalData illegalData}) async {
    final body = illegalData.toJson();
    final response = await ApiSdk.postIllegalRegister(body: body);
    return response;
  }
}
