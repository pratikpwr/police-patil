import 'dart:async';
import 'dart:io';

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
      yield* _mapAddArmsDataState(event);
    }
  }

  String? armsValue;
  String? weaponCondition;
  double longitude = 0.00;
  double latitude = 0.00;
  final List<String> weaponCondTypes = <String>[
    "परवाना धारकाकडे शस्त्र आहे",
    "पो. ठा. कडे जमा",
    "गहाळ",
    "फक्त परवाना आहे शस्त्र नाही",
  ];
  final List<String> armsRegTypes = <String>[
    "शस्त्र परवानाधारक",
    "स्फोटक पदार्थ विक्री",
    "स्फोटक जवळ बाळगणारे",
    "स्फोटक उडविणारे"
  ];

  String fileName = 'आधार कार्ड जोडा';
  String photoName = "परवान्याचा फोटो जोडा";

  File? file;
  File? photo;

  Stream<ArmsRegisterState> _mapGetArmsDataState(GetArmsData event) async* {
    yield ArmsDataLoading();
    try {
      Response _response = await _armsRepository.getArmsRegister();

      if (_response.statusCode! < 400) {
        final _armsResponse = ArmsResponse.fromJson(_response.data);
        yield ArmsDataLoaded(_armsResponse);
      } else {
        yield ArmsLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield ArmsLoadError(err.toString());
    }
  }

  Stream<ArmsRegisterState> _mapAddArmsDataState(AddArmsData event) async* {
    yield ArmsDataSending();
    try {
      Response _response =
          await _armsRepository.addArmsData(armsData: event.armsData);

      if (_response.data["message"] != null) {
        yield ArmsDataSent(_response.data["message"]);
      } else {
        yield ArmsDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield ArmsDataSendError(err.toString());
    }
  }
}
