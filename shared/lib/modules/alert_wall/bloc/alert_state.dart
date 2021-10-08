part of 'alert_bloc.dart';

abstract class AlertState extends Equatable {
  const AlertState();

  @override
  List<Object> get props => [];
}

class AlertInitial extends AlertState {}

class AlertLoading extends AlertState {}

class AlertLoaded extends AlertState {
  final AlertResponse alertResponse;

  const AlertLoaded(this.alertResponse);

  @override
  List<Object> get props => [alertResponse];
}

class AlertLoadError extends AlertState {
  final String error;

  const AlertLoadError(this.error);

  @override
  List<Object> get props => [error];
}
