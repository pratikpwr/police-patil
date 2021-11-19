part of 'crime_register_bloc.dart';

abstract class CrimeRegisterEvent extends Equatable {
  const CrimeRegisterEvent();

  @override
  List<Object> get props => [];
}

class GetCrimeData extends CrimeRegisterEvent {}

class AddCrimeData extends CrimeRegisterEvent {
  final CrimeData crimeData;

  const AddCrimeData(this.crimeData);

  @override
  List<Object> get props => [crimeData];
}

class EditCrimeData extends CrimeRegisterEvent {
  final CrimeData crimeData;

  const EditCrimeData(this.crimeData);

  @override
  List<Object> get props => [crimeData];
}

class DeleteCrimeData extends CrimeRegisterEvent {
  final int id;

  const DeleteCrimeData(this.id);

  @override
  List<Object> get props => [id];
}
