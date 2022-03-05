part of 'village_safety_bloc.dart';

abstract class VillageSafetyEvent extends Equatable {
  const VillageSafetyEvent();

  @override
  List<Object> get props => [];
}

class GetVillageSafetyData extends VillageSafetyEvent {}

class AddVillageSafetyData extends VillageSafetyEvent {
  final VillageSafetyData safetyData;

  const AddVillageSafetyData(this.safetyData);

  @override
  List<Object> get props => [safetyData];
}
