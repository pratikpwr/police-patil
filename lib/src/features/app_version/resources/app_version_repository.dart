import '../../../core/api/api.dart';

class AppVersionRepository {
  Future<dynamic> appVersion() async {
    final response = await ApiSdk.appVersion();
    return response;
  }
}
