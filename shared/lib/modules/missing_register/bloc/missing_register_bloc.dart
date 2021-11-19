import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/missing_register/models/missing_model.dart';
import 'package:shared/modules/missing_register/resources/missing_repository.dart';
import 'package:dio/dio.dart';
import '../../../shared.dart';

part 'missing_register_event.dart';

part 'missing_register_state.dart';

class MissingRegisterBloc
    extends Bloc<MissingRegisterEvent, MissingRegisterState> {
  MissingRegisterBloc() : super(MissingRegisterInitial());
  final _missingRepository = MissingRepository();

  @override
  Stream<MissingRegisterState> mapEventToState(
    MissingRegisterEvent event,
  ) async* {
    if (event is GetMissingData) {
      yield* _mapGetMissingDataState(event);
    }
    if (event is AddMissingData) {
      yield* _mapAddMissingDataState(event);
    }
    if (event is EditMissingData) {
      yield* _mapEditMissingDataState(event);
    }
    if (event is DeleteMissingData) {
      yield* _mapDeleteMissingDataState(event);
    }
  }

  var isAbove18;
  String? gender;
  final List<String> genderTypes = <String>["पुरुष", "स्त्री", "इतर"];

  double longitude = 0.00;
  double latitude = 0.00;

  File? photo;
  String photoName = "फोटो जोडा";

  Stream<MissingRegisterState> _mapGetMissingDataState(
      GetMissingData event) async* {
    yield MissingDataLoading();
    try {
      Response _response = await _missingRepository.getMissingRegister();
      if (_response.statusCode! < 400) {
        final _missingResponse = MissingResponse.fromJson(_response.data);
        yield MissingDataLoaded(_missingResponse);
      } else {
        yield MissingLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield MissingLoadError(err.toString());
    }
  }

  Stream<MissingRegisterState> _mapAddMissingDataState(
      AddMissingData event) async* {
    yield MissingDataSending();
    try {
      Response _response = await _missingRepository.addMissingData(
          missingData: event.missingData);

      if (_response.data["message"] != null) {
        yield MissingDataSent(_response.data["message"]);
      } else {
        yield MissingDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield MissingDataSendError(err.toString());
    }
  }

  Stream<MissingRegisterState> _mapEditMissingDataState(
      EditMissingData event) async* {
    yield MissingDataSending();
    try {
      Response _response = await _missingRepository.editMissingData(
          missingData: event.missingData);

      if (_response.data["message"] != null) {
        yield MissingDataEdited(_response.data["message"]);
      } else {
        yield MissingDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield MissingDataSendError(err.toString());
    }
  }

  Stream<MissingRegisterState> _mapDeleteMissingDataState(
      DeleteMissingData event) async* {
    yield MissingDataSending();
    try {
      Response _response =
          await _missingRepository.deleteMissingData(id: event.id);

      if (_response.data["message"] != null) {
        yield MissingDeleted();
      } else {
        yield MissingDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield MissingDataSendError(err.toString());
    }
  }
}
