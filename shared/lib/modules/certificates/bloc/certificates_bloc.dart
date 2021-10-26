import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'certificates_event.dart';

part 'certificates_state.dart';

class CertificatesBloc extends Bloc<CertificatesEvent, CertificatesState> {
  CertificatesBloc() : super(CertificatesInitial());

  @override
  Stream<CertificatesState> mapEventToState(
    CertificatesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
