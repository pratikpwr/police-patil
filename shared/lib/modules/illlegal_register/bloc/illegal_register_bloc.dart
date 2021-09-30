import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'illegal_register_event.dart';

part 'illegal_register_state.dart';

class IllegalRegisterBloc
    extends Bloc<IllegalRegisterEvent, IllegalRegisterState> {
  IllegalRegisterBloc() : super(IllegalRegisterInitial());

  @override
  Stream<IllegalRegisterState> mapEventToState(
    IllegalRegisterEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
