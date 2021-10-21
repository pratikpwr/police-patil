import 'package:api/api.dart';
import 'package:shared/modules/disaster_register/models/disaster_model.dart';

class DisasterRepository {
  Future<dynamic> getDisasterRegister() async {
    final response = await ApiSdk.getDisaster();
    return response;
  }

  Future<dynamic> addDisasterData({required DisasterData disasterData}) async {
    final body = disasterData.toJson();
    final response = await ApiSdk.postDisasterRegister(body: body);
    return response;
  }
}
