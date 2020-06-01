import 'package:get_it/get_it.dart';

import 'services/audio_player_service.dart';
import 'services/config_service.dart';
import 'services/local_file_system_service.dart';
import 'services/file_storage_service.dart';
import 'services/record_service.dart';
import 'services/remote_config_service.dart';
import 'services/user_service.dart';
import 'services/word_suggestion_service.dart';

final locator = GetIt.instance;
Future setupLocator() async {
  locator.registerLazySingleton(() => FileStorageService());
  locator.registerLazySingleton(() => RecordService());
  locator.registerLazySingleton(() => AudioPlayerService());
  locator.registerLazySingleton(() => LocalFileSystemService());
  locator.registerLazySingleton(() => WordSuggestionService());
  locator.registerLazySingleton(() => UserService());
  var configService = ConfigService();
  configService.initialise();
  locator.registerSingleton(configService);

  var remoteConfigService = await RemoteConfigService.getInstance();
  await remoteConfigService.initialise();
  locator.registerSingleton(remoteConfigService);
}
