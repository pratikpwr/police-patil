import 'package:api/api.dart';
import 'package:shared/modules/missing_register/models/missing_model.dart';

class MissingRepository {
  Future<dynamic> getMissingRegisterByPP({required int userId}) async {
    final response = await ApiSdk.getMissingByPP(userId: userId);
    return response;
  }

  Future<dynamic> addMissingData({required MissingData missingData}) async {
    final body = missingData.toJson();
    final response = await ApiSdk.postMissingRegister(body: body);
    return response;
  }
}
