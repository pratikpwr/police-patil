part of 'village_pslist_bloc.dart';

abstract class VillagePSListState extends Equatable {
  const VillagePSListState();

  @override
  List<Object> get props => [];
}

class VillagePSListInitial extends VillagePSListState {}

class VillagePSListLoading extends VillagePSListState {}

class VillagePSListSuccess extends VillagePSListState {
  List<Village> villages;
  List<PoliceStation> policeStations;

  VillagePSListSuccess(this.policeStations, this.villages);

  @override
  List<Object> get props => [policeStations, villages];
}

class VillagePSListFailed extends VillagePSListState {
  String error;

  VillagePSListFailed(this.error);

  @override
  List<Object> get props => [error];
}
