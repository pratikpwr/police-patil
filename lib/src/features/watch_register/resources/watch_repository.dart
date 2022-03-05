import '../../../core/api/api.dart';
import 'package:dio/dio.dart';

import '../models/watch_model.dart';

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

  Future<dynamic> editWatchData({required WatchData watchData}) async {
    Map<String, dynamic> _body = watchData.toJson();
    _body['watchid'] = watchData.id;
    _body['_method'] = 'put';
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.editWatchRegister(body: _formData);
    return response;
  }

  Future<dynamic> deleteWatchData({required int id}) async {
    final _body = {'watchid': id, '_method': 'delete'};
    final response = await ApiSdk.deleteWatchRegister(body: _body);
    return response;
  }
}
