import '../../../core/api/api.dart';
import '../models/illegal_model.dart';
import 'package:dio/dio.dart';

class IllegalRepository {
  Future<dynamic> getIllegalRegister() async {
    final response = await ApiSdk.getIllegal();
    return response;
  }

  Future<dynamic> addIllegalData({required IllegalData illegalData}) async {
    Map<String, dynamic> _body = illegalData.toJson();
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.postIllegalRegister(body: _formData);
    return response;
  }

  Future<dynamic> editIllegalData({required IllegalData illegalData}) async {
    Map<String, dynamic> _body = illegalData.toJson();
    _body['illegalworkid'] = illegalData.id;
    _body['_method'] = 'put';
    FormData _formData = FormData.fromMap(_body);
    final response = await ApiSdk.editIllegalRegister(body: _formData);
    return response;
  }

  Future<dynamic> deleteIllegalData({required int id}) async {
    final _body = {'illegalworkid': id, '_method': 'delete'};
    final response = await ApiSdk.deleteIllegalRegister(body: _body);
    return response;
  }
}
