part of 'certificates_bloc.dart';

abstract class CertificatesEvent extends Equatable {
  const CertificatesEvent();

  @override
  List<Object?> get props => [];
}

class GetCertificatesDakhala extends CertificatesEvent {}
