part of 'arms_register_bloc.dart';

abstract class ArmsRegisterState extends Equatable {
  const ArmsRegisterState();

  @override
  List<Object> get props => [];
}

class ArmsRegisterInitial extends ArmsRegisterState {}

class ArmsDataLoading extends ArmsRegisterState {}

class ArmsDataLoaded extends ArmsRegisterState {
  final ArmsList armsList;

  const ArmsDataLoaded(this.armsList);
}

class ArmsLoadError extends ArmsRegisterState {
  final String message;

  const ArmsLoadError(this.message);
}

class ArmsDataSending extends ArmsRegisterState {}

class ArmsDataSent extends ArmsRegisterState {}

class ArmsDataSendError extends ArmsRegisterState {
  final String message;

  const ArmsDataSendError(this.message);
}
