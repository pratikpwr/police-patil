part of 'arms_register_bloc.dart';

abstract class ArmsRegisterState extends Equatable {
  const ArmsRegisterState();

  @override
  List<Object> get props => [];
}

class ArmsRegisterInitial extends ArmsRegisterState {}

class ArmsDataLoading extends ArmsRegisterState {}

class ArmsDataLoaded extends ArmsRegisterState {
  final ArmsResponse armsResponse;

  const ArmsDataLoaded(this.armsResponse);
}

class ArmsLoadError extends ArmsRegisterState {
  final String message;

  const ArmsLoadError(this.message);
}

class ArmsDataSending extends ArmsRegisterState {}

class ArmsDataSent extends ArmsRegisterState {
  final String message;

  const ArmsDataSent(this.message);
}

class ArmsEditDone extends ArmsRegisterState {
  final String message;

  const ArmsEditDone(this.message);
}

class ArmsDataSendError extends ArmsRegisterState {
  final String error;

  const ArmsDataSendError(this.error);
}

class ArmsDataChangeSuccess extends ArmsRegisterState {}
