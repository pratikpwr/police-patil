import '../../../core/api/api.dart';
import '../models/village_safety_model.dart';

class VillageSafetyRepository {
  Future<dynamic> getVillageSafetyRegister() async {
    final response = await ApiSdk.getVillageSafety();
    return response;
  }

  Future<dynamic> addVillageSafetyData(
      {required VillageSafetyData safetyData}) async {
    final body = safetyData.toJson();
    final response = await ApiSdk.postVillageSafety(body: body);
    return response;
  }
}
