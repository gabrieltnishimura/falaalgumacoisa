import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

class RecordWidget extends StatefulWidget {
  @override
  _RecordWidget createState() => _RecordWidget();
}

class _RecordWidget extends State<RecordWidget> {
  FlutterAudioRecorder _recorder;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            onPressed: _startRecording,
            icon: Icon(Icons.mic),
            color: Colors.grey,
            iconSize: 200,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            onPressed: _stopRecording,
            icon: Icon(Icons.play_arrow),
            color: Colors.green,
            iconSize: 40,
          ),
          IconButton(
            onPressed: _stopRecording,
            icon: Icon(Icons.stop),
            color: Colors.red,
            iconSize: 40,
          ),
          IconButton(
            onPressed: _stopRecording,
            icon: Icon(Icons.restore_from_trash),
            color: Colors.red,
            iconSize: 40,
          ),
        ],
      )
    ]);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  void _startRecording() async {
    await FlutterAudioRecorder.hasPermissions;
    final String path = await _localPath;
    final String filepath = '$path/file.wav';
    File tempLocalFile = File(filepath);
    if (await tempLocalFile.exists()) {
      print('[RECORDING] Cleaning up files');
      await tempLocalFile.delete();
    }

    _recorder = FlutterAudioRecorder(filepath,
        audioFormat: AudioFormat.WAV, sampleRate: 16000);
    await _recorder.initialized;
    await _recorder.start();
    print('[RECORDING] Started');
  }

  void _stopRecording() async {
    print('[RECORDING] Stopped');
    var result = await _recorder.stop();
    print(result.path);
  }
}
