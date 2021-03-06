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
    if (event is EditPublicPlaceData) {
      yield* _mapEditPublicPlaceDataState(event);
    }
    if (event is DeletePublicPlaceData) {
      yield* _mapDeletePublicPlaceDataState(event);
    }
  }


  Stream<PublicPlaceRegisterState> _mapGetPublicPlaceDataState(
      GetPublicPlaceData event) async* {
    yield PublicPlaceDataLoading();
    try {
      Response _response = await _placeRepository.getPlaceRegister();
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

  Stream<PublicPlaceRegisterState> _mapEditPublicPlaceDataState(
      EditPublicPlaceData event) async* {
    yield PublicPlaceDataSending();
    try {
      Response _response =
          await _placeRepository.editPlaceData(placeData: event.placeData);

      if (_response.data["message"] != null) {
        yield PublicPlaceDataEdited(_response.data["message"]);
      } else {
        yield PublicPlaceDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield PublicPlaceDataSendError(err.toString());
    }
  }

  Stream<PublicPlaceRegisterState> _mapDeletePublicPlaceDataState(
      DeletePublicPlaceData event) async* {
    yield PublicPlaceDataLoading();
    try {
      Response _response = await _placeRepository.deletePlaceData(id: event.id);

      if (_response.data["message"] != null) {
        yield PublicPlaceDeleted();
      } else {
        yield PublicPlaceLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield PublicPlaceLoadError(err.toString());
    }
  }
}
