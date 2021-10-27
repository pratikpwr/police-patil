import 'package:api/api.dart';

class MandhanRepository {
  Future<dynamic> getMandhanDakhala(Map<String, dynamic> body) async {
    final response = await ApiSdk.getMandhan(body: body);
    return response;
  }
}
