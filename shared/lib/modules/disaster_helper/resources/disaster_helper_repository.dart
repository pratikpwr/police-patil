import 'package:api/api.dart';
import 'package:shared/modules/disaster_helper/models/helper_model.dart';

class DisasterHelperRepository {
  Future<dynamic> getDisasterHelperRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getDisasterHelperByPP(userId: userId);
    return response;
  }

  Future<dynamic> addDisasterHelperData(
      {required HelperData helperData}) async {
    final body = helperData.toJson();
    final response = await ApiSdk.postDisasterHelper(body: body);
    return response;
  }
}
