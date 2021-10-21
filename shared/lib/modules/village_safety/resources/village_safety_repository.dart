import 'package:api/api.dart';
import 'package:shared/modules/village_safety/village_safety.dart';

class VillageSafetyRepository {
  Future<dynamic> getVillageSafetyRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getVillageSafetyByPP(userId: userId);
    return response;
  }

  Future<dynamic> addVillageSafetyData(
      {required VillageSafetyData safetyData}) async {
    final body = safetyData.toJson();
    final response = await ApiSdk.postVillageSafety(body: body);
    return response;
  }
}
