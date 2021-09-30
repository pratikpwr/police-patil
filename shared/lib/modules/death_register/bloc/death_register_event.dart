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
