part of 'fire_register_bloc.dart';

abstract class FireRegisterState extends Equatable {
  const FireRegisterState();

  @override
  List<Object> get props => [];
}

class FireRegisterInitial extends FireRegisterState {}

class FireDataLoading extends FireRegisterState {}

class FireDataLoaded extends FireRegisterState {
  final FireResponse fireResponse;

  const FireDataLoaded(this.fireResponse);

  @override
  List<Object> get props => [FireResponse];
}

class FireLoadError extends FireRegisterState {
  final String message;

  const FireLoadError(this.message);
}

class FireDataSending extends FireRegisterState {}

class FireDataSent extends FireRegisterState {
  final String message;

  const FireDataSent(this.message);
}

class FireDataSendError extends FireRegisterState {
  final String error;

  const FireDataSendError(this.error);
}
