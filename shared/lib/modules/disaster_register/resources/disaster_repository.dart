import 'package:api/api.dart';
import 'package:shared/modules/disaster_register/models/disaster_model.dart';

class DisasterRepository {
  Future<dynamic> getDisasterRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getDisasterByPP(userId: userId);
    return response;
  }

  Future<dynamic> addDisasterData({required DisasterData disasterData}) async {
    final body = disasterData.toJson();
    final response = await ApiSdk.postDisasterRegister(body: body);
    return response;
  }
}
