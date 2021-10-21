import 'package:api/api.dart';
import 'package:shared/modules/disaster_helper/models/helper_model.dart';

class DisasterHelperRepository {
  Future<dynamic> getDisasterHelperRegister() async {
    final response = await ApiSdk.getDisasterHelper();
    return response;
  }

  Future<dynamic> addDisasterHelperData(
      {required HelperData helperData}) async {
    final body = helperData.toJson();
    final response = await ApiSdk.postDisasterHelper(body: body);
    return response;
  }
}
