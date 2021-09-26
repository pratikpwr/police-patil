import 'package:shared/shared.dart';

class ProfileBlocController {
  ProfileBlocController._();

  static final ProfileBlocController _instance = ProfileBlocController._();

  factory ProfileBlocController() => _instance;

  // ignore: close_sinks
  ProfileBloc profileBloc = ProfileBloc();
}
