part of 'disaster_tools_bloc.dart';

abstract class DisasterToolsState extends Equatable {
  const DisasterToolsState();

  @override
  List<Object> get props => [];
}

class DisasterToolsInitial extends DisasterToolsState {}

class ToolsDataLoading extends DisasterToolsState {}

class ToolsDataLoaded extends DisasterToolsState {
  final ToolsResponse toolsResponse;

  const ToolsDataLoaded(this.toolsResponse);

  @override
  List<Object> get props => [toolsResponse];
}

class ToolsLoadError extends DisasterToolsState {
  final String message;

  const ToolsLoadError(this.message);
}

class ToolsDataSending extends DisasterToolsState {}

class ToolsDataSent extends DisasterToolsState {
  final String message;

  const ToolsDataSent(this.message);
}

class ToolsDataSendError extends DisasterToolsState {
  final String error;

  const ToolsDataSendError(this.error);
}
