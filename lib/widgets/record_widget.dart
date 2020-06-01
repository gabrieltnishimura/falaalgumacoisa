import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:falaalgumacoisa/services/audio_player_service.dart';
import 'package:falaalgumacoisa/services/local_file_system_service.dart';
import 'package:falaalgumacoisa/services/record_service.dart';
import 'package:flutter/material.dart';

import '../service_locator.dart';

class RecordWidget extends StatefulWidget {
  @override
  _RecordWidget createState() => _RecordWidget();
}

class _RecordWidget extends State<RecordWidget> {
  final RecordService _recordService = locator<RecordService>();
  final AudioPlayerService _audioPlayerService = locator<AudioPlayerService>();
  final LocalFileSystemService _localFileSystemService =
      locator<LocalFileSystemService>();
  bool _recording = false;
  bool _recorded = false;
  bool _playing = false;
  File _audioFile;

  Widget getButton() {
    Widget icon = _recording
        ? Icon(Icons.pause)
        : _recorded
            ? _playing ? Icon(Icons.pause) : Icon(Icons.play_arrow)
            : Icon(Icons.mic);

    Function execute = _recording
        ? _stopRecording
        : _recorded
            ? _playing ? _pauseRecording : _playRecording
            : _startRecording;

    return IconButton(
      onPressed: execute,
      icon: icon,
      color: Colors.grey,
      iconSize: 200,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[getButton()],
      ),
    ]);
  }

  void _startRecording() async {
    _audioFile = await _localFileSystemService.createNewFileWithExtension(
        new DateTime.now()
            .millisecondsSinceEpoch
            .toString(), // ensures files are not duplicate files
        LocalFileSystemService.WAV_FORMAT);
    await _recordService.startRecording(_audioFile);
    setState(() {
      _recording = true;
    });
  }

  void _stopRecording() async {
    await _recordService.stopRecording();
    setState(() {
      _recording = false;
      _recorded = true;
    });
  }

  void _playRecording() async {
    await _audioPlayerService.play(_audioFile);
    _waitForCompletion();
    setState(() {
      _playing = true;
    });
  }

  void _waitForCompletion() {
    _audioPlayerService.getState().listen((AudioPlayerState value) {
      if (value == AudioPlayerState.COMPLETED) {
        setState(() {
          _playing = false;
        });
      }
    });
  }

  void _pauseRecording() async {
    await _audioPlayerService.pause();
    setState(() {
      _playing = false;
    });
  }
}
