part of 'disaster_tools_bloc.dart';

abstract class DisasterToolsEvent extends Equatable {
  const DisasterToolsEvent();

  @override
  List<Object> get props => [];
}

class GetToolsData extends DisasterToolsEvent {}

class AddToolsData extends DisasterToolsEvent {
  final ToolsData toolsData;

  const AddToolsData(this.toolsData);

  @override
  List<Object> get props => [toolsData];
}
