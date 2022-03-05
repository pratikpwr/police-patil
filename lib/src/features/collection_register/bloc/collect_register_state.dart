part of 'collect_register_bloc.dart';

abstract class CollectRegisterState extends Equatable {
  const CollectRegisterState();

  @override
  List<Object> get props => [];
}

class CollectionRegisterInitial extends CollectRegisterState {}

class CollectionDataLoading extends CollectRegisterState {}

class CollectionDataLoaded extends CollectRegisterState {
  final CollectionResponse collectionResponse;

  const CollectionDataLoaded(this.collectionResponse);

  @override
  List<Object> get props => [collectionResponse];
}

class CollectionLoadError extends CollectRegisterState {
  final String message;

  const CollectionLoadError(this.message);
}

class CollectionDataSending extends CollectRegisterState {}

class CollectionDataSent extends CollectRegisterState {
  final String message;

  const CollectionDataSent(this.message);
}

class CollectionDataEdited extends CollectRegisterState {
  final String message;

  const CollectionDataEdited(this.message);
}

class CollectionDataSendError extends CollectRegisterState {
  final String error;

  const CollectionDataSendError(this.error);
}

class CollectionDataDeleted extends CollectRegisterState {}
