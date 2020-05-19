import 'dart:io';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          onPressed: _startRecording,
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
          onPressed: _getConfig,
          icon: Icon(Icons.polymer),
          color: Colors.yellow,
          iconSize: 40,
        ),
      ],
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  void _getConfig() async {
    print('[CONFIG] empty for now');
    // final RemoteConfig remoteConfig = await RemoteConfig.instance;
    // await remoteConfig.fetch(expiration: const Duration(hours: 5));
    // await remoteConfig.activateFetched();
    // print('welcome message: ' + remoteConfig.getString('welcome'));
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
