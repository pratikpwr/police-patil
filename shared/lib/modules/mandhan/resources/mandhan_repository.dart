import 'package:api/api.dart';

class MandhanRepository {
  Future<dynamic> getMandhanDakhala(String params) async {
    final response = await ApiSdk.getMandhan(params: params);
    return response;
  }
}
