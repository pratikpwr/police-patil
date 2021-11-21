import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:shared/shared.dart';

part 'certificates_event.dart';

part 'certificates_state.dart';

class CertificatesBloc extends Bloc<CertificatesEvent, CertificatesState> {
  CertificatesBloc() : super(CertificatesInitial());
  final _certificatesRepository = CertificatesRepository();

  @override
  Stream<CertificatesState> mapEventToState(
    CertificatesEvent event,
  ) async* {
    if (event is GetCertificatesDakhala) {
      yield CertificatesLoading();
      try {
        String params = "?name=${event.name}&age=${event.age}";
        Response _response =
            await _certificatesRepository.getPoliceDakhala(params);
        if (_response.data["message"] == "Success") {
          String link = _response.data["link"];
          yield CertificatesSuccess(link);
        } else {
          yield CertificatesError(_response.data["error"]);
        }
      } catch (err) {
        yield CertificatesError(err.toString());
      }
    }
  }
}
