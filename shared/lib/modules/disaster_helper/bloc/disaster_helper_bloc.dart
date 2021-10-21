import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/disaster_helper/disaster_helper.dart';
import 'package:shared/modules/disaster_helper/models/helper_model.dart';
import 'package:dio/dio.dart';

part 'disaster_helper_event.dart';

part 'disaster_helper_state.dart';

class DisasterHelperBloc
    extends Bloc<DisasterHelperEvent, DisasterHelperState> {
  DisasterHelperBloc() : super(DisasterHelperInitial());

  final _helperRepository = DisasterHelperRepository();

  @override
  Stream<DisasterHelperState> mapEventToState(
    DisasterHelperEvent event,
  ) async* {
    if (event is GetHelperData) {
      yield* _mapGetDisasterDataState(event);
    }
    if (event is AddHelperData) {
      yield* _mapAddDisasterDataState(event);
    }
  }

  Stream<DisasterHelperState> _mapGetDisasterDataState(
      GetHelperData event) async* {
    yield HelperDataLoading();
    try {
      Response _response = await _helperRepository.getDisasterHelperRegister();
      if (_response.statusCode! < 400) {
        final _helperResponse = HelperResponse.fromJson(_response.data);
        yield HelperDataLoaded(_helperResponse);
      } else {
        yield HelperLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield HelperLoadError(err.toString());
    }
  }

  Stream<DisasterHelperState> _mapAddDisasterDataState(
      AddHelperData event) async* {
    yield HelperDataSending();
    try {
      Response _response = await _helperRepository.addDisasterHelperData(
          helperData: event.helperData);

      if (_response.data["message"] != null) {
        yield HelperDataSent(_response.data["message"]);
      } else {
        yield HelperDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield HelperDataSendError(err.toString());
    }
  }
}
