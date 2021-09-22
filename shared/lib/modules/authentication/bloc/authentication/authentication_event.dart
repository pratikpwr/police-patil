import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// Fired just after the app is launched
class AppLoadedUp extends AuthenticationEvent {}

class UserLogOut extends AuthenticationEvent {}

class GetUserData extends AuthenticationEvent {}

class UserLogin extends AuthenticationEvent {
  final String email;
  final String password;

  const UserLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
