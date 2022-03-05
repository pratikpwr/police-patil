import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../models/arms_model.dart';
import '../resources/arms_repository.dart';

part 'arms_register_event.dart';

part 'arms_register_state.dart';

class ArmsRegisterBloc extends Bloc<ArmsRegisterEvent, ArmsRegisterState> {
  ArmsRegisterBloc() : super(ArmsRegisterInitial());

  final _armsRepository = ArmsRepository();

  @override
  Stream<ArmsRegisterState> mapEventToState(
    ArmsRegisterEvent event,
  ) async* {
    if (event is GetArmsData) {
      yield* _mapGetArmsDataState(event);
    }
    if (event is AddArmsData) {
      yield* _mapAddArmsDataState(event);
    }
    if (event is EditArmsData) {
      yield* _mapEditArmsDataState(event);
    }
    if (event is DeleteArmsData) {
      yield* _mapDeleteArmsDataState(event);
    }
  }

  Stream<ArmsRegisterState> _mapGetArmsDataState(GetArmsData event) async* {
    yield ArmsDataLoading();
    try {
      Response _response = await _armsRepository.getArmsRegister();

      if (_response.statusCode! < 400) {
        final _armsResponse = ArmsResponse.fromJson(_response.data);
        yield ArmsDataLoaded(_armsResponse);
      } else {
        yield ArmsLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield ArmsLoadError(err.toString());
    }
  }

  Stream<ArmsRegisterState> _mapAddArmsDataState(AddArmsData event) async* {
    yield ArmsDataSending();
    try {
      Response _response =
          await _armsRepository.addArmsData(armsData: event.armsData);

      if (_response.data["message"] != null) {
        yield ArmsDataSent(_response.data["message"]);
      } else {
        yield ArmsDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield ArmsDataSendError(err.toString());
    }
  }

  Stream<ArmsRegisterState> _mapEditArmsDataState(EditArmsData event) async* {
    yield ArmsDataSending();
    try {
      Response _response =
          await _armsRepository.editArmsData(armsData: event.armsData);

      if (_response.data["message"] != null) {
        yield ArmsEditDone(_response.data["message"]);
      } else {
        yield ArmsDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield ArmsDataSendError(err.toString());
    }
  }

  Stream<ArmsRegisterState> _mapDeleteArmsDataState(
      DeleteArmsData event) async* {
    yield ArmsDataLoading();
    try {
      Response _response = await _armsRepository.deleteArmsData(id: event.id);

      if (_response.data["message"] == "Success") {
        yield ArmsDataChangeSuccess();
      } else {
        yield ArmsLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield ArmsLoadError(err.toString());
    }
  }
}
