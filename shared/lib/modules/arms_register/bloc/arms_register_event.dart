part of 'arms_register_bloc.dart';

abstract class ArmsRegisterEvent extends Equatable {
  const ArmsRegisterEvent();

  @override
  List<Object> get props => [];
}

class GetArmsData extends ArmsRegisterEvent {}

class AddArmsData extends ArmsRegisterEvent {
  final ArmsData armsData;

  const AddArmsData(this.armsData);

  @override
  List<Object> get props => [armsData];
}

class EditArmsData extends ArmsRegisterEvent {
  final ArmsData armsData;

  const EditArmsData(this.armsData);

  @override
  List<Object> get props => [armsData];
}

class DeleteArmsData extends ArmsRegisterEvent {
  final int id;

  const DeleteArmsData(this.id);

  @override
  List<Object> get props => [id];
}
