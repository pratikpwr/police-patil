import '../../../core/api/api.dart';

class CertificatesRepository {
  Future<dynamic> getPoliceDakhala(String params) async {
    final response = await ApiSdk.getCertificate(params: params);
    return response;
  }
}
