import 'dart:async';
import 'dart:io';

import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

class RecordService {
  FlutterAudioRecorder _recorder;

  Future<File> get targetFile async {
    final directory = await getApplicationDocumentsDirectory();
    await FlutterAudioRecorder.hasPermissions;
    final String path = directory.path;
    final String filepath = '$path/file.wav';
    File tempLocalFile = File(filepath);
    if (await tempLocalFile.exists()) {
      print('[RECORDING] Cleaning up files');
      await tempLocalFile.delete();
    }
    return tempLocalFile;
  }

  Future<dynamic> startRecording(File file) async {
    _recorder = FlutterAudioRecorder(file.path,
        audioFormat: AudioFormat.WAV, sampleRate: 16000);
    await _recorder.initialized;

    print('[RECORDING] Starting');
    return _recorder.start().then((started) {
      print('[RECORDING] Started');
      return started;
    });
  }

  Future<Recording> stopRecording() {
    print('[RECORDING] Stopping');
    return _recorder.stop().then((recording) {
      print('[RECORDING] Stopped and saved file at ' + recording.path);
      return recording;
    });
  }
}
