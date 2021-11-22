import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/crime_register/models/crime_model.dart';
import 'package:dio/dio.dart';
import 'package:shared/modules/crime_register/resources/crime_repository.dart';
import '../../../shared.dart';

part 'crime_register_event.dart';

part 'crime_register_state.dart';

class CrimeRegisterBloc extends Bloc<CrimeRegisterEvent, CrimeRegisterState> {
  CrimeRegisterBloc() : super(CrimeRegisterInitial());
  final _crimeRepository = CrimeRepository();

  @override
  Stream<CrimeRegisterState> mapEventToState(
    CrimeRegisterEvent event,
  ) async* {
    if (event is GetCrimeData) {
      yield* _mapGetCrimeDataState(event);
    }
    if (event is AddCrimeData) {
      yield* _mapAddCrimeDataState(event);
    }
    if (event is EditCrimeData) {
      yield* _mapEditCrimeDataState(event);
    }
    if (event is DeleteCrimeData) {
      yield* _mapDeleteCrimeDataState(event);
    }
  }

  Stream<CrimeRegisterState> _mapGetCrimeDataState(GetCrimeData event) async* {
    yield CrimeDataLoading();
    try {
      Response _response = await _crimeRepository.getCrimeRegister();
      if (_response.statusCode! < 400) {
        final _crimeResponse = CrimeResponse.fromJson(_response.data);
        yield CrimeDataLoaded(_crimeResponse);
      } else {
        yield CrimeLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield CrimeLoadError(err.toString());
    }
  }

  Stream<CrimeRegisterState> _mapAddCrimeDataState(AddCrimeData event) async* {
    yield CrimeDataSending();
    try {
      Response _response =
          await _crimeRepository.addCrimeData(crimeData: event.crimeData);

      if (_response.data["message"] != null) {
        yield CrimeDataSent(_response.data["message"]);
      } else {
        yield CrimeDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield CrimeDataSendError(err.toString());
    }
  }

  Stream<CrimeRegisterState> _mapEditCrimeDataState(
      EditCrimeData event) async* {
    yield CrimeDataSending();
    try {
      Response _response =
          await _crimeRepository.editCrimeData(crimeData: event.crimeData);

      if (_response.data["message"] != null) {
        yield CrimeDataEdited(_response.data["message"]);
      } else {
        yield CrimeDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield CrimeDataSendError(err.toString());
    }
  }

  Stream<CrimeRegisterState> _mapDeleteCrimeDataState(
      DeleteCrimeData event) async* {
    yield CrimeDataLoading();
    try {
      Response _response = await _crimeRepository.deleteCrimeData(id: event.id);

      if (_response.data["message"] != null) {
        yield CrimeDataDeleted();
      } else {
        yield CrimeLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield CrimeLoadError(err.toString());
    }
  }
}
