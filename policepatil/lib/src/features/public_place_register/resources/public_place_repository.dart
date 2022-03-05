import '../../../core/api/api.dart';
import 'package:dio/dio.dart';

import '../models/public_place_model.dart';

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

  Future<dynamic> editPlaceData({required PlaceData placeData}) async {
    Map<String, dynamic> _body = placeData.toJson();
    _body['publicplaceid'] = placeData.id;
    _body['_method'] = 'put';
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.editPlaceRegister(body: _formData);
    return response;
  }

  Future<dynamic> deletePlaceData({required int id}) async {
    final _body = {'publicplaceid': id, '_method': 'delete'};
    final response = await ApiSdk.deletePlaceRegister(body: _body);
    return response;
  }
}
