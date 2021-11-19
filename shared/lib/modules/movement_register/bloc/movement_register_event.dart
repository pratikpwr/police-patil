part of 'movement_register_bloc.dart';

abstract class MovementRegisterEvent extends Equatable {
  const MovementRegisterEvent();

  @override
  List<Object> get props => [];
}

class GetMovementData extends MovementRegisterEvent {}

class AddMovementData extends MovementRegisterEvent {
  final MovementData movementData;

  const AddMovementData(this.movementData);

  @override
  List<Object> get props => [movementData];
}

class EditMovementData extends MovementRegisterEvent {
  final MovementData movementData;

  const EditMovementData(this.movementData);

  @override
  List<Object> get props => [movementData];
}

class DeleteMovementData extends MovementRegisterEvent {
  final int id;

  const DeleteMovementData(this.id);

  @override
  List<Object> get props => [id];
}
