part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {
  // final bool isSignIn;
  //
  // SplashLoadComplete({required this.isSignIn});
  //
  // @override
  // List<Object> get props => [isSignIn];
}
