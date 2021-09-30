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
