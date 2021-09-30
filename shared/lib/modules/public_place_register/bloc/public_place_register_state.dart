part of 'public_place_register_bloc.dart';

abstract class PublicPlaceRegisterState extends Equatable {
  const PublicPlaceRegisterState();

  @override
  List<Object> get props => [];
}

class PublicPlaceRegisterInitial extends PublicPlaceRegisterState {}

class PublicPlaceDataLoading extends PublicPlaceRegisterState {}

class PublicPlaceDataLoaded extends PublicPlaceRegisterState {
  final PlaceResponse placeResponse;

  const PublicPlaceDataLoaded(this.placeResponse);

  @override
  List<Object> get props => [PlaceResponse];
}

class PublicPlaceLoadError extends PublicPlaceRegisterState {
  final String message;

  const PublicPlaceLoadError(this.message);
}

class PublicPlaceDataSending extends PublicPlaceRegisterState {}

class PublicPlaceDataSent extends PublicPlaceRegisterState {
  final String message;

  const PublicPlaceDataSent(this.message);
}

class PublicPlaceDataSendError extends PublicPlaceRegisterState {
  final String error;

  const PublicPlaceDataSendError(this.error);
}
