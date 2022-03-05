part of 'mandhan_bloc.dart';

abstract class MandhanEvent extends Equatable {
  const MandhanEvent();

  @override
  List<Object?> get props => [];
}

class GetMandhanDakhala extends MandhanEvent {
  final int count;

  const GetMandhanDakhala(this.count);

  @override
  List<Object> get props => [count];
}
