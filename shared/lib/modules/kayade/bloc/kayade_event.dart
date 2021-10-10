part of 'kayade_bloc.dart';

abstract class KayadeEvent extends Equatable {
  const KayadeEvent();

  @override
  List<Object> get props => [];
}

class GetKayade extends KayadeEvent {}
