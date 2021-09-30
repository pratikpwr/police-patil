import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fire_register_event.dart';

part 'fire_register_state.dart';

class FireRegisterBloc extends Bloc<FireRegisterEvent, FireRegisterState> {
  FireRegisterBloc() : super(FireRegisterInitial());

  @override
  Stream<FireRegisterState> mapEventToState(
    FireRegisterEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
