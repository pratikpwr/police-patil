part of 'death_register_bloc.dart';

abstract class DeathRegisterEvent extends Equatable {
  const DeathRegisterEvent();

  @override
  List<Object> get props => [];
}

class GetDeathData extends DeathRegisterEvent {}

class AddDeathData extends DeathRegisterEvent {
  final DeathData deathData;

  const AddDeathData(this.deathData);

  @override
  List<Object> get props => [deathData];
}

class EditDeathData extends DeathRegisterEvent {
  final DeathData deathData;

  const EditDeathData(this.deathData);

  @override
  List<Object> get props => [deathData];
}

class DeleteDeathData extends DeathRegisterEvent {
  final int id;

  const DeleteDeathData(this.id);

  @override
  List<Object> get props => [id];
}
