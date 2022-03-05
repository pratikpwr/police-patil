import '../../../core/api/api.dart';

class KayadeRepository {
  Future<dynamic> getKayade() async {
    final response = await ApiSdk.getKayade();
    return response;
  }
}
