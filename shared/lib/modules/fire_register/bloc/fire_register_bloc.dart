import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/fire_register/models/fire_model.dart';
import 'package:shared/modules/fire_register/resources/fire_repository.dart';
import 'package:dio/dio.dart';
import '../../../shared.dart';

part 'fire_register_event.dart';

part 'fire_register_state.dart';

class FireRegisterBloc extends Bloc<FireRegisterEvent, FireRegisterState> {
  FireRegisterBloc() : super(FireRegisterInitial());
  final _fireRepository = FireRepository();

  @override
  Stream<FireRegisterState> mapEventToState(
    FireRegisterEvent event,
  ) async* {
    if (event is GetFireData) {
      yield* _mapGetFireDataState(event);
    }
    if (event is AddFireData) {
      yield* _mapAddFireDataState(event);
    }
    if (event is EditFireData) {
      yield* _mapEditFireDataState(event);
    }
    if (event is DeleteFireData) {
      yield* _mapDeleteFireDataState(event);
    }
  }



  Stream<FireRegisterState> _mapGetFireDataState(GetFireData event) async* {
    yield FireDataLoading();
    try {
      Response _response = await _fireRepository.getFireRegister();
      if (_response.statusCode! < 400) {
        final _fireResponse = FireResponse.fromJson(_response.data);
        yield FireDataLoaded(_fireResponse);
      } else {
        yield FireLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield FireLoadError(err.toString());
    }
  }

  Stream<FireRegisterState> _mapAddFireDataState(AddFireData event) async* {
    yield FireDataSending();
    try {
      Response _response =
          await _fireRepository.addFireData(fireData: event.fireData);

      if (_response.data["message"] != null) {
        yield FireDataSent(_response.data["message"]);
      } else {
        yield FireDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield FireDataSendError(err.toString());
    }
  }

  Stream<FireRegisterState> _mapEditFireDataState(EditFireData event) async* {
    yield FireDataSending();
    try {
      Response _response =
          await _fireRepository.editFireData(fireData: event.fireData);

      if (_response.data["message"] != null) {
        yield FireDataEdited(_response.data["message"]);
      } else {
        yield FireDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield FireDataSendError(err.toString());
    }
  }

  Stream<FireRegisterState> _mapDeleteFireDataState(
      DeleteFireData event) async* {
    yield FireDataLoading();
    try {
      Response _response = await _fireRepository.deleteFireData(id: event.id);

      if (_response.data["message"] != null) {
        yield FireDataDeleted();
      } else {
        yield FireLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield FireLoadError(err.toString());
    }
  }
}
