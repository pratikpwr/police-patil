import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/movement_register/models/movement_model.dart';
import 'package:shared/modules/movement_register/resources/movement_repository.dart';
import 'package:dio/dio.dart';

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
    if (event is EditMovementData) {
      yield* _mapEditMovementDataState(event);
    }
    if (event is DeleteMovementData) {
      yield* _mapDeleteMovementDataState(event);
    }
  }

  Stream<MovementRegisterState> _mapGetMovementDataState(
      GetMovementData event) async* {
    yield MovementDataLoading();
    try {
      Response _response = await _movementRepository.getMovementRegister();
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

  Stream<MovementRegisterState> _mapEditMovementDataState(
      EditMovementData event) async* {
    yield MovementDataSending();
    try {
      Response _response = await _movementRepository.editMovementData(
          movementData: event.movementData);

      if (_response.data["message"] != null) {
        yield MovementDataEdited(_response.data["message"]);
      } else {
        yield MovementDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield MovementDataSendError(err.toString());
    }
  }

  Stream<MovementRegisterState> _mapDeleteMovementDataState(
      DeleteMovementData event) async* {
    yield MovementDataLoading();
    try {
      Response _response =
          await _movementRepository.deleteMovementData(id: event.id);

      if (_response.data["message"] != null) {
        yield MovementDeleted();
      } else {
        yield MovementDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield MovementDataSendError(err.toString());
    }
  }
}
