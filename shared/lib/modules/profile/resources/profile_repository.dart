import 'package:api/api.dart';

class ProfileRepository {
  Future<dynamic> getUserData(int id) async {
    final response = await ApiSdk.getUserData(userId: id);
    return response;
  }
}
