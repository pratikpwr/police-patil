import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import '../../../shared.dart';

part 'public_place_register_event.dart';

part 'public_place_register_state.dart';

class PublicPlaceRegisterBloc
    extends Bloc<PublicPlaceRegisterEvent, PublicPlaceRegisterState> {
  PublicPlaceRegisterBloc() : super(PublicPlaceRegisterInitial());
  final _placeRepository = PlaceRepository();

  @override
  Stream<PublicPlaceRegisterState> mapEventToState(
    PublicPlaceRegisterEvent event,
  ) async* {
    if (event is GetPublicPlaceData) {
      yield* _mapGetPublicPlaceDataState(event);
    }
    if (event is AddPublicPlaceData) {
      yield* _mapAddPublicPlaceDataState(event);
    }
  }

  String? chosenValue;

  double longitude = 0.00;
  double latitude = 0.00;

  File? photo;
  String photoName = "फोटो जोडा";

  final List<String> socialPlaceTypes = <String>[
    "रस्ता",
    "पाणवठा",
    "जमीन",
    "पुतळा",
    "धार्मिक स्थळ",
    "इतर"
  ];

  var isIssue;
  var isCCTV;
  var isCrimeReg;

  Stream<PublicPlaceRegisterState> _mapGetPublicPlaceDataState(
      GetPublicPlaceData event) async* {
    final sharedPrefs = await prefs;
    yield PublicPlaceDataLoading();
    try {
      int? userId = sharedPrefs.getInt('userId');
      Response _response =
          await _placeRepository.getPlaceRegisterByPP(userId: userId!);
      if (_response.statusCode! < 400) {
        final _placeResponse = PlaceResponse.fromJson(_response.data);
        yield PublicPlaceDataLoaded(_placeResponse);
      } else {
        yield PublicPlaceLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield PublicPlaceLoadError(err.toString());
    }
  }

  Stream<PublicPlaceRegisterState> _mapAddPublicPlaceDataState(
      AddPublicPlaceData event) async* {
    yield PublicPlaceDataSending();
    try {
      final sharedPrefs = await prefs;
      event.placeData.ppid = sharedPrefs.getInt('userId')!;
      event.placeData.psid = sharedPrefs.getInt('policeStationId')!;

      Response _response =
          await _placeRepository.addPlaceData(placeData: event.placeData);

      if (_response.data["message"] != null) {
        yield PublicPlaceDataSent(_response.data["message"]);
      } else {
        yield PublicPlaceDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield PublicPlaceDataSendError(err.toString());
    }
  }
}
