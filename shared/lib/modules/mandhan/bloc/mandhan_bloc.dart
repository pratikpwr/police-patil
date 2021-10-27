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
      try {
        Map<String, dynamic> body = {"count": int.parse(chosenValue!)};
        Response _response = await _mandhanRepository.getMandhanDakhala(body);
        if (_response.data["message"] == "Success") {
          String link = _response.data["data"]["link"];
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
