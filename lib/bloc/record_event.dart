part of 'record_bloc.dart';

@immutable
abstract class RecordEvent {}

class StartRecordingEvent extends RecordEvent {}

class StopRecordingEvent extends RecordEvent {}

class StartPlayingEvent extends RecordEvent {}

class StopPlayingEvent extends RecordEvent {}

class PausePlayingEvent extends RecordEvent {}
