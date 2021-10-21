import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/disaster_tools/models/tools_model.dart';
import 'package:shared/modules/disaster_tools/resources/disaster_tools_repository.dart';
import 'package:dio/dio.dart';

part 'disaster_tools_event.dart';

part 'disaster_tools_state.dart';

class DisasterToolsBloc extends Bloc<DisasterToolsEvent, DisasterToolsState> {
  DisasterToolsBloc() : super(DisasterToolsInitial());
  final _toolsRepository = DisasterToolsRepository();

  @override
  Stream<DisasterToolsState> mapEventToState(
    DisasterToolsEvent event,
  ) async* {
    if (event is GetToolsData) {
      yield* _mapGetDisasterDataState(event);
    }
    if (event is AddToolsData) {
      yield* _mapAddDisasterDataState(event);
    }
  }

  Stream<DisasterToolsState> _mapGetDisasterDataState(
      GetToolsData event) async* {
    yield ToolsDataLoading();
    try {
      Response _response = await _toolsRepository.getDisasterToolsRegister();
      if (_response.statusCode! < 400) {
        final _toolsResponse = ToolsResponse.fromJson(_response.data);
        yield ToolsDataLoaded(_toolsResponse);
      } else {
        yield ToolsLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield ToolsLoadError(err.toString());
    }
  }

  Stream<DisasterToolsState> _mapAddDisasterDataState(
      AddToolsData event) async* {
    yield ToolsDataSending();
    try {
      Response _response = await _toolsRepository.addDisasterToolsData(
          toolsData: event.toolsData);

      if (_response.data["message"] != null) {
        yield ToolsDataSent(_response.data["message"]);
      } else {
        yield ToolsDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield ToolsDataSendError(err.toString());
    }
  }
}
