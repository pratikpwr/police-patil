import 'package:api/api.dart';
import 'package:shared/modules/collection_register/models/collect_model.dart';
import 'package:dio/dio.dart';

class CollectRepository {
  Future<dynamic> getCollectionsRegister() async {
    final response = await ApiSdk.getCollect();
    return response;
  }

  Future<dynamic> addCollectionsData(
      {required CollectionData collectionData}) async {
    Map<String, dynamic> _body = collectionData.toJson();

    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postCollectRegister(body: _formData);
    return response;
  }

  Future<dynamic> editArmsData({required CollectionData collect}) async {
    Map<String, dynamic> _body = collect.toJson();
    _body['seizeid'] = collect.id;
    _body['_method'] = 'put';
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.editCollectRegister(body: _formData);
    return response;
  }

  Future<dynamic> deleteArmsData({required int id}) async {
    final _body = {'seizeid': id, '_method': 'delete'};
    final response = await ApiSdk.deleteCollectRegister(body: _body);
    return response;
  }
}
