import '../../../core/api/api.dart';
import '../models/crime_model.dart';

class CrimeRepository {
  Future<dynamic> getCrimeRegister() async {
    final response = await ApiSdk.getCrime();
    return response;
  }

  Future<dynamic> addCrimeData({required CrimeData crimeData}) async {
    final body = crimeData.toJson();
    final response = await ApiSdk.postCrimeRegister(body: body);
    return response;
  }

  Future<dynamic> editCrimeData({required CrimeData crimeData}) async {
    Map<String, dynamic> _body = crimeData.toJson();
    _body['crimeid'] = crimeData.id;
    _body['_method'] = 'put';
    final response = await ApiSdk.editCrimeRegister(body: _body);
    return response;
  }

  Future<dynamic> deleteCrimeData({required int id}) async {
    final _body = {'crimeid': id, '_method': 'delete'};
    final response = await ApiSdk.deleteCrimeRegister(body: _body);
    return response;
  }
}
