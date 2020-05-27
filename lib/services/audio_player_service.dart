import 'dart:async';
import 'dart:io';

import 'package:audioplayer/audioplayer.dart';

class AudioPlayerService {
  AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> play(File file) async {
    print('[PLAYER] Starting ' + file.path);
    return await _audioPlayer.play(file.path, isLocal: true);
  }

  Future<int> pause() {
    print('[PLAYER] Pausing');
    return _audioPlayer.pause();
  }

  Future<int> stop() {
    return _audioPlayer.stop();
  }

  Stream<AudioPlayerState> getState() {
    return _audioPlayer.onPlayerStateChanged;
  }
}
