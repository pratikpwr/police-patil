import 'dart:io';

import 'package:api/api.dart';
import 'package:shared/modules/collection_register/models/collect_model.dart';
import 'package:dio/dio.dart';

class CollectRepository {
  Future<dynamic> getCollectionsRegister() async {
    final response = await ApiSdk.getCollect();
    return response;
  }

  Future<dynamic> addCollectionsData({required CollectionData collectionData}) async {
    Map<String, dynamic> _body = collectionData.toJson();
    String path = _body['photo'] ?? "";
    bool directoryExists = await Directory(path).exists();
    bool fileExists = await File(path).exists();
    if (directoryExists || fileExists) {
      _body['photo'] = await MultipartFile.fromFile(path);
    }

    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postCollectRegister(body: _formData);
    return response;
  }
}
