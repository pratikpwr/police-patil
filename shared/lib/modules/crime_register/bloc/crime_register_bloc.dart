import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'crime_register_event.dart';

part 'crime_register_state.dart';

class CrimeRegisterBloc extends Bloc<CrimeRegisterEvent, CrimeRegisterState> {
  CrimeRegisterBloc() : super(CrimeRegisterInitial());

  @override
  Stream<CrimeRegisterState> mapEventToState(
    CrimeRegisterEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
