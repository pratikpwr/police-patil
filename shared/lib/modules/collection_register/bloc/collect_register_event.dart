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
