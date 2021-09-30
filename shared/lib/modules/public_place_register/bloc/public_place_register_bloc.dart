import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'public_place_register_event.dart';

part 'public_place_register_state.dart';

class PublicPlaceRegisterBloc
    extends Bloc<PublicPlaceRegisterEvent, PublicPlaceRegisterState> {
  PublicPlaceRegisterBloc() : super(PublicPlaceRegisterInitial());

  @override
  Stream<PublicPlaceRegisterState> mapEventToState(
    PublicPlaceRegisterEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
