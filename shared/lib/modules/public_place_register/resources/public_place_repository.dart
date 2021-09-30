import 'package:api/api.dart';
import 'package:shared/modules/public_place_register/models/public_place_model.dart';

class PlaceRepository {
  Future<dynamic> getPlaceRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getPlaceByPP(userId: userId);
    return response;
  }

  Future<dynamic> addPlaceData({required PlaceData placeData}) async {
    final body = placeData.toJson();
    final response = await ApiSdk.postPlaceRegister(body: body);
    return response;
  }
}
