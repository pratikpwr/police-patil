import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/disaster_model.dart';
import '../resources/disaster_repository.dart';

part 'disaster_register_event.dart';

part 'disaster_register_state.dart';

class DisasterRegisterBloc
    extends Bloc<DisasterRegisterEvent, DisasterRegisterState> {
  DisasterRegisterBloc() : super(DisasterRegisterInitial());
  final _disasterRepository = DisasterRepository();

  String? chosenType;
  String? chosenSubType;
  double longitude = 0.00;
  double latitude = 0.00;
  final disasterTypes = ["नैसर्गिक", "मानवनिर्मित"];
  List<String>? subTypes;
  final naturalTypes = [
    "दरड",
    "पूर",
    "दुष्काळ",
    "भुकंप",
    "विज",
    "वणवा",
    "इतर",
  ];
  final manMadeTypes = [
    "विस्फोट",
    "आग",
    "मोठे अपघात",
    "इतर",
  ];
  List<DisasterArea> areas = [
    DisasterArea(title: "दरड प्रवण", isSelected: false),
    DisasterArea(title: "पूर प्रवण", isSelected: false),
    DisasterArea(title: "दुष्काळ प्रवण", isSelected: false),
    DisasterArea(title: "भुकंप प्रवण", isSelected: false),
    DisasterArea(title: "MIDC", isSelected: false),
    DisasterArea(title: "इतर", isSelected: false),
  ];

  List<String> selectedAreas = [];

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
    if (event is AddDisasterArea) {
      yield* _mapAddDisasterAreaState(event);
    }
    if (event is GetDisasterArea) {
      yield* _mapGetDisasterAreaState(event);
    }
  }

  Stream<DisasterRegisterState> _mapGetDisasterDataState(
      GetDisasterData event) async* {
    yield DisasterDataLoading();
    try {
      Response _response = await _disasterRepository.getDisasterRegister();
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

  Stream<DisasterRegisterState> _mapAddDisasterAreaState(
      AddDisasterArea event) async* {
    yield DisasterAreaSending();
    try {
      final SharedPreferences sharedPrefs =
          await SharedPreferences.getInstance();
      int? userId = sharedPrefs.getInt('userId');

      Map<String, dynamic> body = {"dangerzone": event.areas};
      Response _response =
          await _disasterRepository.addDisasterArea(id: userId!, body: body);

      if (_response.data["message"] != null) {
        yield DisasterAreaSent(_response.data["message"]);
      } else {
        yield DisasterAreaSendError(_response.data["error"]);
      }
    } catch (err) {
      yield DisasterAreaSendError(err.toString());
    }
  }

  Stream<DisasterRegisterState> _mapGetDisasterAreaState(
      GetDisasterArea event) async* {
    yield DisasterAreaLoading();
    try {
      Response _response = await _disasterRepository.getDisasterArea();
      if (_response.data["message"] == "Success") {
        List<String> areasPrev = [];
        areasPrev
            .addAll(List<String>.from(_response.data["data"].map((x) => x)));
        yield DisasterAreaLoaded(areasPrev);
      } else {
        yield DisasterAreaSendError(_response.data["error"]);
      }
    } catch (err) {
      yield DisasterAreaSendError(err.toString());
    }
  }

  List<String> getSubType() {
    if (chosenType == "नैसर्गिक") {
      return naturalTypes;
    } else if (chosenType == "मानवनिर्मित") {
      return manMadeTypes;
    } else {
      return ["अगोदर प्रकार निवडा"];
    }
  }
}
