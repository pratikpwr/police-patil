part of 'illegal_register_bloc.dart';

abstract class IllegalRegisterEvent extends Equatable {
  const IllegalRegisterEvent();

  @override
  List<Object> get props => [];
}

class GetIllegalData extends IllegalRegisterEvent {}

class AddIllegalData extends IllegalRegisterEvent {
  final IllegalData illegalData;

  const AddIllegalData(this.illegalData);

  @override
  List<Object> get props => [illegalData];
}

class EditIllegalData extends IllegalRegisterEvent {
  final IllegalData illegalData;

  const EditIllegalData(this.illegalData);

  @override
  List<Object> get props => [illegalData];
}

class DeleteIllegalData extends IllegalRegisterEvent {
  final int id;

  const DeleteIllegalData(this.id);

  @override
  List<Object> get props => [id];
}
