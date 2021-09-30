import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'missing_register_event.dart';

part 'missing_register_state.dart';

class MissingRegisterBloc
    extends Bloc<MissingRegisterEvent, MissingRegisterState> {
  MissingRegisterBloc() : super(MissingRegisterInitial());

  @override
  Stream<MissingRegisterState> mapEventToState(
    MissingRegisterEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
