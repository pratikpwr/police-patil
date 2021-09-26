import 'package:shared/shared.dart';
import 'authentication_bloc.dart';

class AuthenticationBlocController {
  AuthenticationBlocController._();

  static final AuthenticationBlocController _instance =
      AuthenticationBlocController._();

  factory AuthenticationBlocController() => _instance;

  // ignore: close_sinks
  AuthenticationBloc authenticationBloc = AuthenticationBloc();
}
