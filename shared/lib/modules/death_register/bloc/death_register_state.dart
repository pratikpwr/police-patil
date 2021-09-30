part of 'death_register_bloc.dart';

abstract class DeathRegisterState extends Equatable {
  const DeathRegisterState();

  @override
  List<Object> get props => [];
}

class DeathRegisterInitial extends DeathRegisterState {}

class DeathDataLoading extends DeathRegisterState {}

class DeathDataLoaded extends DeathRegisterState {
  final DeathResponse deathResponse;

  const DeathDataLoaded(this.deathResponse);

  @override
  List<Object> get props => [DeathResponse];
}

class DeathLoadError extends DeathRegisterState {
  final String message;

  const DeathLoadError(this.message);
}

class DeathDataSending extends DeathRegisterState {}

class DeathDataSent extends DeathRegisterState {
  final String message;

  const DeathDataSent(this.message);
}

class DeathDataSendError extends DeathRegisterState {
  final String error;

  const DeathDataSendError(this.error);
}
