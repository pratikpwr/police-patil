import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/movement_register/models/movement_model.dart';
import 'package:shared/modules/movement_register/resources/movement_repository.dart';
import 'package:dio/dio.dart';
import '../../../shared.dart';

part 'movement_register_event.dart';

part 'movement_register_state.dart';

class MovementRegisterBloc
    extends Bloc<MovementRegisterEvent, MovementRegisterState> {
  MovementRegisterBloc() : super(MovementRegisterInitial());
  final _movementRepository = MovementRepository();

  @override
  Stream<MovementRegisterState> mapEventToState(
    MovementRegisterEvent event,
  ) async* {
    if (event is GetMovementData) {
      yield* _mapGetMovementDataState(event);
    }
    if (event is AddMovementData) {
      yield* _mapAddMovementDataState(event);
    }
  }

  Stream<MovementRegisterState> _mapGetMovementDataState(
      GetMovementData event) async* {
    final sharedPrefs = await prefs;
    yield MovementDataLoading();
    try {
      int? userId = sharedPrefs.getInt('userId');
      Response _response =
          await _movementRepository.getMovementRegisterByPP(userId: userId!);
      if (_response.statusCode! < 400) {
        final _movementResponse = MovementResponse.fromJson(_response.data);
        yield MovementDataLoaded(_movementResponse);
      } else {
        yield MovementLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield MovementLoadError(err.toString());
    }
  }

  Stream<MovementRegisterState> _mapAddMovementDataState(
      AddMovementData event) async* {
    yield MovementDataSending();
    try {
      final sharedPrefs = await prefs;
      event.movementData.ppid = sharedPrefs.getInt('userId')!;
      event.movementData.psid = sharedPrefs.getInt('policeStationId')!;

      Response _response = await _movementRepository.addMovementData(
          movementData: event.movementData);

      if (_response.data["message"] != null) {
        yield MovementDataSent(_response.data["message"]);
      } else {
        yield MovementDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield MovementDataSendError(err.toString());
    }
  }
}
