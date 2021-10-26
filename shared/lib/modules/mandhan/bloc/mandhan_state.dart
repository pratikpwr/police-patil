part of 'mandhan_bloc.dart';

abstract class MandhanState extends Equatable {
  const MandhanState();

  @override
  List<Object> get props => [];
}

class MandhanInitial extends MandhanState {}

class MandhanLoading extends MandhanState {}

class MandhanSuccess extends MandhanState {
  final String link;

  const MandhanSuccess(this.link);

  @override
  List<Object> get props => [link];
}

class MandhanError extends MandhanState {
  final String error;

  const MandhanError(this.error);

  @override
  List<Object> get props => [error];
}
