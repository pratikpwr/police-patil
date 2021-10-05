import 'package:api/api.dart';
import 'package:shared/modules/watch_register/models/watch_model.dart';

class WatchRepository {
  Future<dynamic> getWatchRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getWatchByPP(userId: userId);
    return response;
  }

  Future<dynamic> addWatchData({required WatchData watchData}) async {
    final body = watchData.toJson();
    final response = await ApiSdk.postWatchRegister(body: body);
    print(response.toString());
    return response;
  }
}
