part of 'certificates_bloc.dart';

abstract class CertificatesEvent extends Equatable {
  const CertificatesEvent();

  @override
  List<Object?> get props => [];
}

class GetCertificatesDakhala extends CertificatesEvent {
  final String name;
  final String age;

  const GetCertificatesDakhala({required this.name, required this.age});

  @override
  List<Object> get props => [name, age];
}
