part of 'missing_register_bloc.dart';

abstract class MissingRegisterState extends Equatable {
  const MissingRegisterState();

  @override
  List<Object> get props => [];
}

class MissingRegisterInitial extends MissingRegisterState {}

class MissingDataLoading extends MissingRegisterState {}

class MissingDataLoaded extends MissingRegisterState {
  final MissingResponse missingResponse;

  const MissingDataLoaded(this.missingResponse);

  @override
  List<Object> get props => [MissingResponse];
}

class MissingLoadError extends MissingRegisterState {
  final String message;

  const MissingLoadError(this.message);
}

class MissingDataSending extends MissingRegisterState {}

class MissingDataSent extends MissingRegisterState {
  final String message;

  const MissingDataSent(this.message);
}

class MissingDataSendError extends MissingRegisterState {
  final String error;

  const MissingDataSendError(this.error);
}
