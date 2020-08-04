import 'dart:io';

import 'package:falaalgumacoisa/services/audio_player_service.dart';
import 'package:falaalgumacoisa/services/config_service.dart';
import 'package:falaalgumacoisa/services/file_storage_service.dart';
import 'package:falaalgumacoisa/services/local_file_system_service.dart';
import 'package:falaalgumacoisa/services/record_service.dart';
import 'package:falaalgumacoisa/services/remote_config_service.dart';
import 'package:falaalgumacoisa/services/word_suggestion_service.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
Future setupMockLocators() async {
  locator.registerLazySingleton<FileStorageService>(
      () => FileStorageServiceMock());
  locator.registerLazySingleton<RecordService>(() => RecordServiceMock());
  locator.registerLazySingleton<AudioPlayerService>(
      () => AudioPlayerServiceMock());
  locator.registerLazySingleton<LocalFileSystemService>(
      () => LocalFileSystemServiceMock());
  locator.registerLazySingleton<WordSuggestionService>(
      () => WordSuggestionServiceMock());
  var configService = ConfigServiceMock();
  configService.initialise();
  locator.registerSingleton<ConfigService>(configService);

  var remoteConfigService = await RemoteConfigService.getInstance();
  await remoteConfigService.initialise();
  locator.registerSingleton<RemoteConfigService>(remoteConfigService);
}

class FileStorageServiceMock extends FileStorageService {}

class RecordServiceMock extends RecordService {
  Future<dynamic> startRecording(File file) async {
    return null;
  }

  Future<Recording> stopRecording() {
    return null;
  }
}

class AudioPlayerServiceMock extends AudioPlayerService {
  Future<void> play(File file) async {
    return null;
  }

  Future<int> pause() {
    return null;
  }
}

class LocalFileSystemServiceMock extends LocalFileSystemService {
  Future<File> createNewFileWithExtension(String filename, String ext) async {
    return null;
  }
}

class WordSuggestionServiceMock extends WordSuggestionService {}

class ConfigServiceMock extends ConfigService {}
