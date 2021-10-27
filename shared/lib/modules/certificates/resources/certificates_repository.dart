import 'package:api/api.dart';

class CertificatesRepository {
  Future<dynamic> getPoliceDakhala(Map<String, dynamic> body) async {
    final response = await ApiSdk.getCertificate(body: body);
    return response;
  }
}
