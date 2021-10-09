import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/disaster_register/models/disaster_model.dart';
import 'package:dio/dio.dart';
import 'package:shared/modules/disaster_register/resources/disaster_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'disaster_register_event.dart';

part 'disaster_register_state.dart';

class DisasterRegisterBloc
    extends Bloc<DisasterRegisterEvent, DisasterRegisterState> {
  DisasterRegisterBloc() : super(DisasterRegisterInitial());
  final _disasterRepository = DisasterRepository();

  @override
  Stream<DisasterRegisterState> mapEventToState(
    DisasterRegisterEvent event,
  ) async* {
    if (event is GetDisasterData) {
      yield* _mapGetDisasterDataState(event);
    }
    if (event is AddDisasterData) {
      yield* _mapAddDisasterDataState(event);
    }
  }

  Stream<DisasterRegisterState> _mapGetDisasterDataState(
      GetDisasterData event) async* {
    final sharedPrefs = await SharedPreferences.getInstance();
    yield DisasterDataLoading();
    try {
      int? userId = sharedPrefs.getInt('userId');
      Response _response =
          await _disasterRepository.getDisasterRegisterByPP(userId: userId!);
      if (_response.statusCode! < 400) {
        final _disasterResponse = DisasterResponse.fromJson(_response.data);
        yield DisasterDataLoaded(_disasterResponse);
      } else {
        yield DisasterLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield DisasterLoadError(err.toString());
    }
  }

  Stream<DisasterRegisterState> _mapAddDisasterDataState(
      AddDisasterData event) async* {
    yield DisasterDataSending();
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      event.disasterData.ppid = sharedPrefs.getInt('userId')!;
      event.disasterData.psid = sharedPrefs.getInt('policeStationId')!;

      Response _response = await _disasterRepository.addDisasterData(
          disasterData: event.disasterData);

      if (_response.data["message"] != null) {
        yield DisasterDataSent(_response.data["message"]);
      } else {
        yield DisasterDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield DisasterDataSendError(err.toString());
    }
  }
}
