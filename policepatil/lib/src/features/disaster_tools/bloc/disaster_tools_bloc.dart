import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../models/tools_model.dart';
import '../resources/disaster_tools_repository.dart';

part 'disaster_tools_event.dart';

part 'disaster_tools_state.dart';

class DisasterToolsBloc extends Bloc<DisasterToolsEvent, DisasterToolsState> {
  DisasterToolsBloc() : super(DisasterToolsInitial());
  final _toolsRepository = DisasterToolsRepository();

  String? chosenValue;
  List<String> tools = [
    "वॉटर प्रुफ थ्री पोल राहुटी",
    "श्री पोल राहुटी",
    "नाईट रिप्लेक्टीव्ह जॅकेट",
    "लाईफ जॅकेट (रेस्क्यू जॅकेट)",
    "रोप, कॅरॉबिनर व ग्लोज रेस्क्यू करीता",
    "गम बुट",
    "सर्च लाईट",
    "रिचार्जेबल एल इ डी टॉर्च",
    "रेन कोर्ट",
    "बायनाक्युलर दुर्बिन",
    "लाईट रिफ्लेक्टर बॅटन",
    "नाईलॉन रोप",
    "कुऱ्हाड",
    "हेक्सा लाईट",
    "रक्षक बोटी",
    "वॉटर ट्यूब",
    "प्लास्टीक हेल्मेट",
    "इतर"
  ];

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
