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

class EditFireData extends FireRegisterEvent {
  final FireData fireData;

  const EditFireData(this.fireData);

  @override
  List<Object> get props => [fireData];
}

class DeleteFireData extends FireRegisterEvent {
  final int id;

  const DeleteFireData(this.id);

  @override
  List<Object> get props => [id];
}
