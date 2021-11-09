import 'package:api/api.dart';
import 'package:shared/modules/watch_register/models/watch_model.dart';
import 'package:dio/dio.dart';

class WatchRepository {
  Future<dynamic> getWatchRegister({String? params}) async {
    final response = await ApiSdk.getWatch(params: params);
    return response;
  }

  Future<dynamic> addWatchData({required WatchData watchData}) async {
    Map<String, dynamic> _body = watchData.toJson();
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postWatchRegister(body: _formData);
    return response;
  }
}
