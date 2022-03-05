import '../../../core/api/api.dart';

class AlertRepository {
  Future<dynamic> getAlerts() async {
    final response = await ApiSdk.getAlerts();
    return response;
  }
}
