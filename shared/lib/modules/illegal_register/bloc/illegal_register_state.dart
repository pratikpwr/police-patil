part of 'illegal_register_bloc.dart';

abstract class IllegalRegisterState extends Equatable {
  const IllegalRegisterState();

  @override
  List<Object> get props => [];
}

class IllegalRegisterInitial extends IllegalRegisterState {}

class IllegalDataLoading extends IllegalRegisterState {}

class IllegalDataLoaded extends IllegalRegisterState {
  final IllegalResponse illegalResponse;

  const IllegalDataLoaded(this.illegalResponse);

  @override
  List<Object> get props => [IllegalResponse];
}

class IllegalLoadError extends IllegalRegisterState {
  final String message;

  const IllegalLoadError(this.message);
}

class IllegalDataSending extends IllegalRegisterState {}

class IllegalDataSent extends IllegalRegisterState {
  final String message;

  const IllegalDataSent(this.message);
}

class IllegalDataSendError extends IllegalRegisterState {
  final String error;

  const IllegalDataSendError(this.error);
}
