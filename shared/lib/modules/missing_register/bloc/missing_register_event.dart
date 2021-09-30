part of 'missing_register_bloc.dart';

abstract class MissingRegisterEvent extends Equatable {
  const MissingRegisterEvent();

  @override
  List<Object> get props => [];
}

class GetMissingData extends MissingRegisterEvent {}

class AddMissingData extends MissingRegisterEvent {
  final MissingData missingData;

  const AddMissingData(this.missingData);

  @override
  List<Object> get props => [missingData];
}
