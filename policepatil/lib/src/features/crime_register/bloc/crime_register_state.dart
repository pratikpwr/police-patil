part of 'crime_register_bloc.dart';

abstract class CrimeRegisterState extends Equatable {
  const CrimeRegisterState();

  @override
  List<Object> get props => [];
}

class CrimeRegisterInitial extends CrimeRegisterState {}

class CrimeDataLoading extends CrimeRegisterState {}

class CrimeDataLoaded extends CrimeRegisterState {
  final CrimeResponse crimeResponse;

  const CrimeDataLoaded(this.crimeResponse);

  @override
  List<Object> get props => [CrimeResponse];
}

class CrimeLoadError extends CrimeRegisterState {
  final String message;

  const CrimeLoadError(this.message);
}

class CrimeDataSending extends CrimeRegisterState {}

class CrimeDataSent extends CrimeRegisterState {
  final String message;

  const CrimeDataSent(this.message);
}

class CrimeDataEdited extends CrimeRegisterState {
  final String message;

  const CrimeDataEdited(this.message);
}

class CrimeDataSendError extends CrimeRegisterState {
  final String error;

  const CrimeDataSendError(this.error);
}

class CrimeDataDeleted extends CrimeRegisterState {}
