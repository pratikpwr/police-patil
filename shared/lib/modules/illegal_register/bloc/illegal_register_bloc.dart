import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/illegal_register/models/illegal_model.dart';
import 'package:dio/dio.dart';
import 'package:shared/modules/illegal_register/resources/illegal_repository.dart';
import '../../../shared.dart';

part 'illegal_register_event.dart';

part 'illegal_register_state.dart';

class IllegalRegisterBloc
    extends Bloc<IllegalRegisterEvent, IllegalRegisterState> {
  IllegalRegisterBloc() : super(IllegalRegisterInitial());

  final _illegalRepository = IllegalRepository();

  @override
  Stream<IllegalRegisterState> mapEventToState(
    IllegalRegisterEvent event,
  ) async* {
    if (event is GetIllegalData) {
      yield* _mapGetIllegalDataState(event);
    }
    if (event is AddIllegalData) {
      yield* _mapAddIllegalDataState(event);
    }
  }

  Stream<IllegalRegisterState> _mapGetIllegalDataState(
      GetIllegalData event) async* {
    final sharedPrefs = await prefs;
    yield IllegalDataLoading();
    try {
      int? userId = sharedPrefs.getInt('userId');
      Response _response =
          await _illegalRepository.getIllegalRegisterByPP(userId: userId!);
      if (_response.statusCode! < 400) {
        final _illegalResponse = IllegalResponse.fromJson(_response.data);
        yield IllegalDataLoaded(_illegalResponse);
      } else {
        yield IllegalLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield IllegalLoadError(err.toString());
    }
  }

  Stream<IllegalRegisterState> _mapAddIllegalDataState(
      AddIllegalData event) async* {
    yield IllegalDataSending();
    try {
      final sharedPrefs = await prefs;
      event.illegalData.ppid = sharedPrefs.getInt('userId')!;
      event.illegalData.psid = sharedPrefs.getInt('policeStationId')!;

      Response _response = await _illegalRepository.addIllegalData(
          illegalData: event.illegalData);

      if (_response.data["message"] != null) {
        yield IllegalDataSent(_response.data["message"]);
      } else {
        yield IllegalDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield IllegalDataSendError(err.toString());
    }
  }
}
