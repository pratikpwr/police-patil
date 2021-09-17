import 'package:api/api.dart';
import 'package:dio/dio.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      // () => _controller.add(AuthenticationStatus.authenticated),
    );
  }
}
