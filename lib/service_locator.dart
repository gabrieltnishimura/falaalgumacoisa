import 'package:falaalgumacoisa/services/config_service.dart';
import 'package:falaalgumacoisa/services/file_storage_service.dart';
import 'package:get_it/get_it.dart';

import 'services/remote_config_service.dart';

final locator = GetIt.instance;
Future setupLocator() async {
  locator.registerLazySingleton(() => FileStorageService());
  var configService = ConfigService();
  configService.initialise();
  locator.registerSingleton(configService);

  var remoteConfigService = await RemoteConfigService.getInstance();
  await remoteConfigService.initialise();
  locator.registerSingleton(remoteConfigService);
}
