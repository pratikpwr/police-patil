part of 'disaster_helper_bloc.dart';

abstract class DisasterHelperEvent extends Equatable {
  const DisasterHelperEvent();

  @override
  List<Object> get props => [];
}

class GetHelperData extends DisasterHelperEvent {}

class AddHelperData extends DisasterHelperEvent {
  final HelperData helperData;

  const AddHelperData(this.helperData);

  @override
  List<Object> get props => [helperData];
}
