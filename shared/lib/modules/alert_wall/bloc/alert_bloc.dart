import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/alert_wall/models/alert_model.dart';
import 'package:shared/modules/alert_wall/resources/alert_repository.dart';
import 'package:dio/dio.dart';

part 'alert_event.dart';

part 'alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  AlertBloc() : super(AlertInitial());
  final _alertRepository = AlertRepository();

  @override
  Stream<AlertState> mapEventToState(
    AlertEvent event,
  ) async* {
    if (event is GetAlerts) {
      yield AlertLoading();
      try {
        Response _response = await _alertRepository.getAlerts();
        if (_response.data["error"] == null) {
          final _news = AlertResponse.fromJson(_response.data);
          yield AlertLoaded(_news);
        } else {
          yield AlertLoadError(_response.data["error"].toString());
        }
      } catch (err) {
        yield AlertLoadError(err.toString());
      }
    }
  }
}
