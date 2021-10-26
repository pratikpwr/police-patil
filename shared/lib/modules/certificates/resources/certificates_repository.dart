import 'package:api/api.dart';

class CertificatesRepository {
  Future<dynamic> getPoliceDakhala(dynamic body) async {
    final response = await ApiSdk.getCertificate(body: body);
    return response;
  }
}
