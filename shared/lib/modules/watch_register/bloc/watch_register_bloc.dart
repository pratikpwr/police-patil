import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/watch_register/models/watch_model.dart';
import 'package:dio/dio.dart';
import 'package:shared/modules/watch_register/resources/watch_repository.dart';
import '../../../shared.dart';

part 'watch_register_event.dart';

part 'watch_register_state.dart';

class WatchRegisterBloc extends Bloc<WatchRegisterEvent, WatchRegisterState> {
  WatchRegisterBloc() : super(WatchRegisterInitial());
  final _watchRepository = WatchRepository();

  @override
  Stream<WatchRegisterState> mapEventToState(
    WatchRegisterEvent event,
  ) async* {
    if (event is GetWatchData) {
      yield* _mapGetWatchDataState(event);
    }
    if (event is AddWatchData) {
      yield* _mapAddWatchDataState(event);
    }
    if (event is EditWatchData) {
      yield* _mapEditWatchDataState(event);
    }
    if (event is DeleteWatchData) {
      yield* _mapDeleteWatchDataState(event);
    }
  }

  Stream<WatchRegisterState> _mapGetWatchDataState(GetWatchData event) async* {
    yield WatchDataLoading();
    try {
      String? params = getParams(event);
      Response _response =
          await _watchRepository.getWatchRegister(params: params);
      if (_response.statusCode! < 400) {
        final _watchResponse = WatchResponse.fromJson(_response.data);
        yield WatchDataLoaded(_watchResponse);
      } else {
        yield WatchLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield WatchLoadError(err.toString());
    }
  }

  Stream<WatchRegisterState> _mapAddWatchDataState(AddWatchData event) async* {
    yield WatchDataSending();
    try {
      Response _response =
          await _watchRepository.addWatchData(watchData: event.watchData);

      if (_response.data["message"] != null) {
        yield WatchDataSent(_response.data["message"]);
      } else {
        yield WatchDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield WatchDataSendError(err.toString());
    }
  }

  Stream<WatchRegisterState> _mapEditWatchDataState(
      EditWatchData event) async* {
    yield WatchDataSending();
    try {
      Response _response =
          await _watchRepository.editWatchData(watchData: event.watchData);

      if (_response.data["message"] != null) {
        yield WatchDataEdited(_response.data["message"]);
      } else {
        yield WatchDataSendError(_response.data["error"]);
      }
    } catch (err) {
      yield WatchDataSendError(err.toString());
    }
  }

  Stream<WatchRegisterState> _mapDeleteWatchDataState(
      DeleteWatchData event) async* {
    yield WatchDataLoading();
    try {
      Response _response = await _watchRepository.deleteWatchData(
        id: event.id,
      );

      if (_response.data["message"] != null) {
        yield WatchDataDeleted(_response.data["message"]);
      } else {
        yield WatchLoadError(_response.data["error"]);
      }
    } catch (err) {
      yield WatchLoadError(err.toString());
    }
  }

  String getParams(GetWatchData event) {
    String _params = "?";

    if (event.type != null) {
      if (event.type == "सर्व") {
        _params += "";
      } else {
        _params += "type=${event.type}&";
      }
    }
    if (event.psId != null) {
      _params += "psid=${event.psId}&";
    }
    if (event.ppId != null) {
      _params += "ppid=${event.ppId}&";
    }
    if (event.fromDate != null && event.fromDate != "") {
      _params += "fromdate=${event.fromDate}&";
    }
    if (event.toDate != null && event.toDate != "") {
      _params += "todate=${event.toDate}&";
    }
    return _params;
  }
}
