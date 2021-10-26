part of 'certificates_bloc.dart';

abstract class CertificatesState extends Equatable {
  const CertificatesState();

  @override
  List<Object> get props => [];
}

class CertificatesInitial extends CertificatesState {}

class CertificatesLoading extends CertificatesState {}

class CertificatesSuccess extends CertificatesState {
  final String link;

  const CertificatesSuccess(this.link);

  @override
  List<Object> get props => [link];
}

class CertificatesError extends CertificatesState {
  final String error;

  const CertificatesError(this.error);

  @override
  List<Object> get props => [error];
}
