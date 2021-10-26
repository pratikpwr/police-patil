part of 'disaster_register_bloc.dart';

abstract class DisasterRegisterEvent extends Equatable {
  const DisasterRegisterEvent();

  @override
  List<Object> get props => [];
}

class GetDisasterData extends DisasterRegisterEvent {}

class AddDisasterData extends DisasterRegisterEvent {
  final DisasterData disasterData;

  const AddDisasterData(this.disasterData);

  @override
  List<Object> get props => [disasterData];
}

class AddDisasterArea extends DisasterRegisterEvent {
  final List<String> areas;

  const AddDisasterArea(this.areas);

  @override
  List<Object> get props => [areas];
}

class GetDisasterArea extends DisasterRegisterEvent {}
