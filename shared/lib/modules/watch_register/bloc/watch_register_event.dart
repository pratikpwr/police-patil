part of 'watch_register_bloc.dart';

abstract class WatchRegisterEvent extends Equatable {
  const WatchRegisterEvent();

  @override
  List<Object> get props => [];
}

class GetWatchData extends WatchRegisterEvent {
  String? type, psId, ppId, fromDate, toDate;

  GetWatchData({this.type, this.psId, this.ppId, this.fromDate, this.toDate});
}

class AddWatchData extends WatchRegisterEvent {
  final WatchData watchData;

  const AddWatchData(this.watchData);

  @override
  List<Object> get props => [watchData];
}
