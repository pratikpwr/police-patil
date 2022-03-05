import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../models/kayade_model.dart';
import '../resources/kayade_repository.dart';

part 'kayade_event.dart';

part 'kayade_state.dart';

class KayadeBloc extends Bloc<KayadeEvent, KayadeState> {
  KayadeBloc() : super(KayadeInitial());
  final _kayadeRepository = KayadeRepository();

  @override
  Stream<KayadeState> mapEventToState(
    KayadeEvent event,
  ) async* {
    if (event is GetKayade) {
      yield KayadeLoading();
      try {
        Response _response = await _kayadeRepository.getKayade();
        if (_response.data["error"] == null) {
          final _news = KayadeResponse.fromJson(_response.data);
          yield KayadeLoaded(_news);
        } else {
          yield KayadeLoadError(_response.data["error"].toString());
        }
      } catch (err) {
        yield KayadeLoadError(err.toString());
      }
    }
  }
}
