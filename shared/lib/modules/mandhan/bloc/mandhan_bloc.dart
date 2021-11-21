import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/shared.dart';
import 'package:dio/dio.dart';

part 'mandhan_event.dart';

part 'mandhan_state.dart';

class MandhanBloc extends Bloc<MandhanEvent, MandhanState> {
  MandhanBloc() : super(MandhanInitial());
  final _mandhanRepository = MandhanRepository();
  String? chosenValue;
  final List<String> meetingCount = <String>["0", "1", "2", "3", "4", "5"];

  @override
  Stream<MandhanState> mapEventToState(
    MandhanEvent event,
  ) async* {
    if (event is GetMandhanDakhala) {
      yield MandhanLoading();
      try {
        final sharedPrefs = await prefs;
        final userId = sharedPrefs.getInt('userId');
        String params = "?count=${event.count}&id=$userId";
        Response _response = await _mandhanRepository.getMandhanDakhala(params);
        if (_response.data["message"] == "Success") {
          String link = _response.data["link"];
          yield MandhanSuccess(link);
        } else {
          yield MandhanError(_response.data["error"]);
        }
      } catch (err) {
        yield MandhanError(err.toString());
      }
    }
  }
}
