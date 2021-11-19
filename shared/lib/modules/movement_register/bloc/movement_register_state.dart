part of 'movement_register_bloc.dart';

abstract class MovementRegisterState extends Equatable {
  const MovementRegisterState();

  @override
  List<Object> get props => [];
}

class MovementRegisterInitial extends MovementRegisterState {}

class MovementDataLoading extends MovementRegisterState {}

class MovementDataLoaded extends MovementRegisterState {
  final MovementResponse movementResponse;

  const MovementDataLoaded(this.movementResponse);

  @override
  List<Object> get props => [MovementResponse];
}

class MovementLoadError extends MovementRegisterState {
  final String message;

  const MovementLoadError(this.message);
}

class MovementDataSending extends MovementRegisterState {}

class MovementDataSent extends MovementRegisterState {
  final String message;

  const MovementDataSent(this.message);
}

class MovementDataEdited extends MovementRegisterState {
  final String message;

  const MovementDataEdited(this.message);
}

class MovementDataSendError extends MovementRegisterState {
  final String error;

  const MovementDataSendError(this.error);
}

class MovementDeleted extends MovementRegisterState {}
