import 'package:api/api.dart';

class AuthenticationRepository {
  Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    await Future.delayed(
        const Duration(seconds: 1)); // simulate a network delay
    var data = {'email': email, 'password': password};
    final response = await ApiSdk.loginWithEmailAndPassword(userAuthData: data);

    return response;
  }

  Future<dynamic> getUserData(int id) async {
    var data = {'id': id};
    final response = await ApiSdk.getUserData(userAuthData: data);
    return response;
  }
}
