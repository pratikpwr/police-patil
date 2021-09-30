import 'package:api/api.dart';
import 'package:shared/modules/crime_register/models/crime_model.dart';

class CrimeRepository {
  Future<dynamic> getCrimeRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getCrimeByPP(userId: userId);
    return response;
  }

  Future<dynamic> addCrimeData({required CrimeData crimeData}) async {
    final body = crimeData.toJson();
    final response = await ApiSdk.postCrimeRegister(body: body);
    return response;
  }
}
