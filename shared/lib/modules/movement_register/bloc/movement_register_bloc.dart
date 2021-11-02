import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/movement_register/models/movement_model.dart';
import 'package:shared/modules/movement_register/resources/movement_repository.dart';
import 'package:dio/dio.dart';

part 'movement_register_event.dart';

part 'movement_register_state.dart';

class MovementRegisterBloc
    extends Bloc<MovementRegisterEvent, MovementRegisterState> {
  MovementRegisterBloc() : super(MovementRegisterInitial());
  final _movementRepository = MovementRepository();

  @override
  Stream<MovementRegisterState> mapEventToState(
    MovementRegisterEvent event,
  ) async* {
    if (event is GetMovementData) {
      yield* _mapGetMovementDataState(event);
    }
    if (event is AddMovementData) {
      yield* _mapAddMovementDataState(event);
    }
  }

  String? movementValue;
  String? timeValue;
  String? movementSubValue;
  var isIssue;
  List<String>? movementSubRegTypes;

  double longitude = 0.00;
  double latitude = 0.00;

  String photoName = "हालचालीचा फोटो जोडा";
  File? photo;
  final List<String> timeType = <String>["संभाव्य", "घटित"];
  final List<String> movementRegTypes = <String>[
    "राजकीय हालचाली",
    "धार्मिक हालचाली",
    "जातीय हालचाली",
    "सांस्कृतिक हालचाली"
  ];
  final List<String> politicalMovements = <String>[
    "आंदोलने",
    "सभा",
    "निवडणुका",
    "इतर"
    // "राजकीय संघर्ष/वाद-विवाद"
  ];
  final List<String> religionMovements = <String>[
    "यात्रा/उत्सव",
    "घेण्यात येणारे कार्यक्रम",
    "इतर"
    // "धार्मिक प्रसंगी उद्भवणारे वाद-विवाद"
  ];
  final List<String> castMovements = <String>[
    "कार्यक्रम",
    "जातीय वाद-विवाद",
    "जातीय आंदोलने",
    "इतर"
  ];
  final List<String> culturalMovements = <String>[
    "जयंती/पुण्यतिथी",
    "सण/उत्सव",
    "इतर सांस्कृतिक हालचाली"
  ];

  Stream<MovementRegisterState> _mapGetMovementDataState(
      GetMovementData event) async* {
    yield MovementDataLoading();
    try {
      Response _response = await _movementRepository.getMovementRegister();
      if (_response.statusCode! < 400) {
        final _movementResponse = MovementResponse.fromJson(_response.data);
        yield MovementDataLoaded(_movementResponse);
      } else {
        yield MovementLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield MovementLoadError(err.toString());
    }
  }

  Stream<MovementRegisterState> _mapAddMovementDataState(
      AddMovementData event) async* {
    yield MovementDataSending();
    try {
      Response _response = await _movementRepository.addMovementData(
          movementData: event.movementData);

      if (_response.data["message"] != null) {
        yield MovementDataSent(_response.data["message"]);
      } else {
        yield MovementDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield MovementDataSendError(err.toString());
    }
  }

  List<String> getSubList() {
    if (movementValue == "राजकीय हालचाली") {
      return politicalMovements;
    } else if (movementValue == "धार्मिक हालचाली") {
      return religionMovements;
    } else if (movementValue == "जातीय हालचाली") {
      return castMovements;
    } else if (movementValue == "सांस्कृतिक हालचाली") {
      return culturalMovements;
    } else {
      return ["अगोदर हालचाली प्रकार निवडा"];
    }
  }
}
