import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'death_register_event.dart';

part 'death_register_state.dart';

class DeathRegisterBloc extends Bloc<DeathRegisterEvent, DeathRegisterState> {
  DeathRegisterBloc() : super(DeathRegisterInitial());

  @override
  Stream<DeathRegisterState> mapEventToState(
    DeathRegisterEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
