part of 'fire_register_bloc.dart';

abstract class FireRegisterEvent extends Equatable {
  const FireRegisterEvent();

  @override
  List<Object> get props => [];
}

class GetFireData extends FireRegisterEvent {}

class AddFireData extends FireRegisterEvent {
  final FireData fireData;

  const AddFireData(this.fireData);

  @override
  List<Object> get props => [fireData];
}
