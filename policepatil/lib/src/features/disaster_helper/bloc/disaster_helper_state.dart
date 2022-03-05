part of 'disaster_helper_bloc.dart';

abstract class DisasterHelperState extends Equatable {
  const DisasterHelperState();

  @override
  List<Object> get props => [];
}

class DisasterHelperInitial extends DisasterHelperState {}

class HelperDataLoading extends DisasterHelperState {}

class HelperDataLoaded extends DisasterHelperState {
  final HelperResponse helperResponse;

  const HelperDataLoaded(this.helperResponse);

  @override
  List<Object> get props => [helperResponse];
}

class HelperLoadError extends DisasterHelperState {
  final String message;

  const HelperLoadError(this.message);
}

class HelperDataSending extends DisasterHelperState {}

class HelperDataSent extends DisasterHelperState {
  final String message;

  const HelperDataSent(this.message);
}

class HelperDataSendError extends DisasterHelperState {
  final String error;

  const HelperDataSendError(this.error);
}
