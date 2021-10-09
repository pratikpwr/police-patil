part of 'disaster_register_bloc.dart';

abstract class DisasterRegisterState extends Equatable {
  const DisasterRegisterState();

  @override
  List<Object> get props => [];
}

class DisasterRegisterInitial extends DisasterRegisterState {}

class DisasterDataLoading extends DisasterRegisterState {}

class DisasterDataLoaded extends DisasterRegisterState {
  final DisasterResponse disasterResponse;

  const DisasterDataLoaded(this.disasterResponse);

  @override
  List<Object> get props => [DisasterResponse];
}

class DisasterLoadError extends DisasterRegisterState {
  final String message;

  const DisasterLoadError(this.message);
}

class DisasterDataSending extends DisasterRegisterState {}

class DisasterDataSent extends DisasterRegisterState {
  final String message;

  const DisasterDataSent(this.message);
}

class DisasterDataSendError extends DisasterRegisterState {
  final String error;

  const DisasterDataSendError(this.error);
}
