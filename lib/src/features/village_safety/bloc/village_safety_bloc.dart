import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../models/village_safety_model.dart';
import '../resources/village_safety_repository.dart';

part 'village_safety_event.dart';

part 'village_safety_state.dart';

class VillageSafetyBloc extends Bloc<VillageSafetyEvent, VillageSafetyState> {
  VillageSafetyBloc() : super(VillageSafetyInitial());
  final _villageSafetyRepository = VillageSafetyRepository();

  @override
  Stream<VillageSafetyState> mapEventToState(
    VillageSafetyEvent event,
  ) async* {
    if (event is GetVillageSafetyData) {
      yield* _mapGetDisasterDataState(event);
    }
    if (event is AddVillageSafetyData) {
      yield* _mapAddDisasterDataState(event);
    }
  }

  Stream<VillageSafetyState> _mapGetDisasterDataState(
      GetVillageSafetyData event) async* {
    yield VillageSafetyDataLoading();
    try {
      Response _response =
          await _villageSafetyRepository.getVillageSafetyRegister();
      if (_response.statusCode! < 400) {
        final _villageSafetyResponse =
            VillageSafetyResponse.fromJson(_response.data);
        yield VillageSafetyDataLoaded(_villageSafetyResponse);
      } else {
        yield VillageSafetyLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield VillageSafetyLoadError(err.toString());
    }
  }

  Stream<VillageSafetyState> _mapAddDisasterDataState(
      AddVillageSafetyData event) async* {
    yield VillageSafetyDataSending();
    try {
      Response _response = await _villageSafetyRepository.addVillageSafetyData(
          safetyData: event.safetyData);

      if (_response.data["message"] != null) {
        yield VillageSafetyDataSent(_response.data["message"]);
      } else {
        yield VillageSafetyDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield VillageSafetyDataSendError(err.toString());
    }
  }
}
