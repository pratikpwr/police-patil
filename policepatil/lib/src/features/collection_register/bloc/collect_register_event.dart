part of 'collect_register_bloc.dart';

abstract class CollectRegisterEvent extends Equatable {
  const CollectRegisterEvent();

  @override
  List<Object> get props => [];
}

class GetCollectionData extends CollectRegisterEvent {}

class AddCollectionData extends CollectRegisterEvent {
  final CollectionData collectionData;

  const AddCollectionData(this.collectionData);

  @override
  List<Object> get props => [collectionData];
}

class EditCollectionData extends CollectRegisterEvent {
  final CollectionData collectionData;

  const EditCollectionData(this.collectionData);

  @override
  List<Object> get props => [collectionData];
}

class DeleteCollectionData extends CollectRegisterEvent {
  final int id;

  const DeleteCollectionData(this.id);

  @override
  List<Object> get props => [id];
}
