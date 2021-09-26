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
      _mapAddArmsDataState(event);
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
        final _armsList = ArmsList.fromJson(_response.data);
        yield ArmsDataLoaded(_armsList);
      } else {
        yield ArmsLoadError(_response.data["message"]);
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

      if (_response.statusCode! < 400) {
        //Todo
        yield ArmsDataSent();
      } else {
        yield ArmsDataSendError(_response.data["message"]);
      }
    } catch (err) {
      yield ArmsDataSendError(err.toString());
    }
  }
}
