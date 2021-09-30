part of 'watch_register_bloc.dart';

abstract class WatchRegisterState extends Equatable {
  const WatchRegisterState();

  @override
  List<Object> get props => [];
}

class WatchRegisterInitial extends WatchRegisterState {}

class WatchDataLoading extends WatchRegisterState {}

class WatchDataLoaded extends WatchRegisterState {
  final WatchResponse watchResponse;

  const WatchDataLoaded(this.watchResponse);

  @override
  List<Object> get props => [WatchResponse];
}

class WatchLoadError extends WatchRegisterState {
  final String message;

  const WatchLoadError(this.message);
}

class WatchDataSending extends WatchRegisterState {}

class WatchDataSent extends WatchRegisterState {
  final String message;

  const WatchDataSent(this.message);
}

class WatchDataSendError extends WatchRegisterState {
  final String error;

  const WatchDataSendError(this.error);
}
