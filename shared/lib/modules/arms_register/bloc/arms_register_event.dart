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
