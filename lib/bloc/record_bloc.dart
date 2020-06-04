import 'dart:async';
import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:bloc/bloc.dart';
import 'package:falaalgumacoisa/services/audio_player_service.dart';
import 'package:falaalgumacoisa/services/local_file_system_service.dart';
import 'package:falaalgumacoisa/services/record_service.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'record_event.dart';
part 'record_state.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final RecordService recordService;
  final AudioPlayerService audioPlayerService;
  final LocalFileSystemService localFileSystemService;
  File _audioFile;

  RecordBloc(
      {this.recordService,
      this.audioPlayerService,
      this.localFileSystemService});

  @override
  RecordState get initialState => RecordInitial();

  @override
  Stream<RecordState> mapEventToState(
    RecordEvent event,
  ) async* {
    if (event is StartRecordingEvent) {
      _audioFile = await localFileSystemService.createNewFileWithExtension(
          new DateTime.now()
              .millisecondsSinceEpoch
              .toString(), // ensures files are not duplicate files
          LocalFileSystemService.WAV_FORMAT);
      await this.recordService.startRecording(_audioFile);
      yield RecordRecording();
    } else if (event is StopRecordingEvent) {
      await this.recordService.stopRecording();
      yield RecordRecorded();
    } else if (event is StartPlayingEvent) {
      await this.audioPlayerService.play(_audioFile);
      yield RecordPlaying();
      Stream<AudioPlayerState> states =
          this.audioPlayerService.getState(); // autoclosing
      await for (final state in states) {
        if (state == AudioPlayerState.COMPLETED) {
          yield RecordStopped();
        }
      }
    } else if (event is StopPlayingEvent) {
      yield RecordStopped();
    }
  }
}
