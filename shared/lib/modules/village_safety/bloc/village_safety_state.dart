part of 'village_safety_bloc.dart';

abstract class VillageSafetyState extends Equatable {
  const VillageSafetyState();

  @override
  List<Object> get props => [];
}

class VillageSafetyInitial extends VillageSafetyState {}

class VillageSafetyDataLoading extends VillageSafetyState {}

class VillageSafetyDataLoaded extends VillageSafetyState {
  final VillageSafetyResponse safetyResponse;

  const VillageSafetyDataLoaded(this.safetyResponse);

  @override
  List<Object> get props => [safetyResponse];
}

class VillageSafetyLoadError extends VillageSafetyState {
  final String message;

  const VillageSafetyLoadError(this.message);
}

class VillageSafetyDataSending extends VillageSafetyState {}

class VillageSafetyDataSent extends VillageSafetyState {
  final String message;

  const VillageSafetyDataSent(this.message);
}

class VillageSafetyDataSendError extends VillageSafetyState {
  final String message;

  const VillageSafetyDataSendError(this.message);
}
