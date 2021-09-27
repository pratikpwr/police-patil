import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:shared/modules/arms_register/models/arms_model.dart';
import 'package:shared/modules/arms_register/resources/arms_repository.dart';
import 'package:shared/shared.dart';

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
  }

  Stream<ArmsRegisterState> _mapGetArmsDataState(GetArmsData event) async* {
    final sharedPrefs = await prefs;
    yield ArmsDataLoading();
    try {
      int? userId = sharedPrefs.getInt('userId');
      Response _response =
          await _armsRepository.getArmsRegisterByPP(userId: userId!);

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
      final sharedPrefs = await prefs;
      event.armsData.ppid = sharedPrefs.getInt('userId')!;
      event.armsData.psid = sharedPrefs.getInt('policeStationId')!;

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
}
