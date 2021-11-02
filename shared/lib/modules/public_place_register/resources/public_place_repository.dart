import 'package:api/api.dart';
import 'package:shared/modules/public_place_register/models/public_place_model.dart';
import 'package:dio/dio.dart';

class PlaceRepository {
  Future<dynamic> getPlaceRegister() async {
    final response = await ApiSdk.getPlace();
    return response;
  }

  Future<dynamic> addPlaceData({required PlaceData placeData}) async {
    Map<String, dynamic> _body = placeData.toJson();
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postPlaceRegister(body: _formData);
    return response;
  }
}
