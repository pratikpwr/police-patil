import '../../../core/api/api.dart';

class AuthenticationRepository {
  Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    // simulate a network delay
    var data = {'email': email, 'password': password};
    final response = await ApiSdk.loginWithEmailAndPassword(userAuthData: data);

    return response;
  }
}
