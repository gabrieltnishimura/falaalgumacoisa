part of 'record_bloc.dart';

@immutable
abstract class RecordState {
  final RecordEvent nextEvent = null;
  final Icon icon = null;
}

class RecordInitial extends RecordState {
  final RecordEvent nextEvent = StartRecordingEvent();
  final Icon icon = Icon(Icons.mic);
}

class RecordRecording extends RecordState {
  final RecordEvent nextEvent = StopRecordingEvent();
  final Icon icon = Icon(Icons.stop);
}

class RecordRecorded extends RecordState {
  final RecordEvent nextEvent = StartPlayingEvent();
  final Icon icon = Icon(Icons.play_arrow);
}

class RecordPlaying extends RecordState {
  final RecordEvent nextEvent = StopPlayingEvent();
  final Icon icon = Icon(Icons.pause);
}

class RecordStopped extends RecordState {
  final RecordEvent nextEvent = StartPlayingEvent();
  final Icon icon = Icon(Icons.play_arrow);
}
