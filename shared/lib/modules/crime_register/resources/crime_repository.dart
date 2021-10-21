import 'package:api/api.dart';
import 'package:shared/modules/crime_register/models/crime_model.dart';

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
}
