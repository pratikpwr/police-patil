import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/death_register/models/death_model.dart';
import 'package:dio/dio.dart';
import 'package:shared/modules/death_register/resources/death_repository.dart';
import '../../../shared.dart';

part 'death_register_event.dart';

part 'death_register_state.dart';

class DeathRegisterBloc extends Bloc<DeathRegisterEvent, DeathRegisterState> {
  DeathRegisterBloc() : super(DeathRegisterInitial());
  final _deathRepository = DeathRepository();

  @override
  Stream<DeathRegisterState> mapEventToState(
    DeathRegisterEvent event,
  ) async* {
    if (event is GetDeathData) {
      yield* _mapGetDeathDataState(event);
    }
    if (event is AddDeathData) {
      yield* _mapAddDeathDataState(event);
    }
    if (event is EditDeathData) {
      yield* _mapEditDeathDataState(event);
    }
    if (event is DeleteDeathData) {
      yield* _mapDeleteDeathDataState(event);
    }
  }

  Stream<DeathRegisterState> _mapGetDeathDataState(GetDeathData event) async* {
    yield DeathDataLoading();
    try {
      Response _response = await _deathRepository.getDeathRegister();
      if (_response.statusCode! < 400) {
        final _deathResponse = DeathResponse.fromJson(_response.data);
        yield DeathDataLoaded(_deathResponse);
      } else {
        yield DeathLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield DeathLoadError(err.toString());
    }
  }

  Stream<DeathRegisterState> _mapAddDeathDataState(AddDeathData event) async* {
    yield DeathDataSending();
    try {
      Response _response =
          await _deathRepository.addDeathData(deathData: event.deathData);

      if (_response.data["message"] != null) {
        yield DeathDataSent(_response.data["message"]);
      } else {
        yield DeathDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield DeathDataSendError(err.toString());
    }
  }

  Stream<DeathRegisterState> _mapEditDeathDataState(
      EditDeathData event) async* {
    yield DeathDataSending();
    try {
      Response _response =
          await _deathRepository.editDeathData(deathData: event.deathData);

      if (_response.data["message"] != null) {
        yield DeathDataEdited(_response.data["message"]);
      } else {
        yield DeathDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield DeathDataSendError(err.toString());
    }
  }

  Stream<DeathRegisterState> _mapDeleteDeathDataState(
      DeleteDeathData event) async* {
    yield DeathDataLoading();
    try {
      Response _response = await _deathRepository.deleteDeathData(id: event.id);

      if (_response.data["message"] != null) {
        yield DeathDataDeleted();
      } else {
        yield DeathLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield DeathLoadError(err.toString());
    }
  }
}
