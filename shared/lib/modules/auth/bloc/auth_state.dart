part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final bool isAuth;

  const AuthSuccess(this.isAuth);

  @override
  List<Object> get props => [isAuth];
}

// class AuthFailure extends AuthState {
//   final int statusCode;
//   final String error;
//
//   AuthFailure({this.statusCode, this.error});
//
//   @override
//   List<Object> get props => [statusCode, error];
// }
