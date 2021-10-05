import 'package:api/api.dart';
import 'package:shared/modules/collection_register/models/collect_model.dart';
import 'package:dio/dio.dart';

class CollectRepository {
  Future<dynamic> getCollectionsRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getCollectByPP(userId: userId);
    return response;
  }

  Future<dynamic> addCollectionsData(
      {required CollectionData collectionData}) async {
    Map<String, dynamic> _body = collectionData.toJson();

    _body['photo'] = await MultipartFile.fromFile(_body['photo']);
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postCollectRegister(body: _formData);
    return response;
  }
}
