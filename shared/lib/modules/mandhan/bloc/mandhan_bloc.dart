import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mandhan_event.dart';

part 'mandhan_state.dart';

class MandhanBloc extends Bloc<MandhanEvent, MandhanState> {
  MandhanBloc() : super(MandhanInitial());

  @override
  Stream<MandhanState> mapEventToState(
    MandhanEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
