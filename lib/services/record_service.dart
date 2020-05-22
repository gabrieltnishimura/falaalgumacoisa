import 'dart:io';

import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

class RecordService {
  FlutterAudioRecorder _recorder;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future record() async {
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

    print('[RECORDING] Starting');
    return _recorder.start().then((started) {
      print('[RECORDING] Started');
      return started;
    });
  }

  Future<Recording> stop() {
    print('[RECORDING] Stopping');
    return _recorder.stop().then((recording) {
      print('[RECORDING] Stopped and saved file at ' + recording.path);
      return recording;
    });
  }

  void play() async {}
}
