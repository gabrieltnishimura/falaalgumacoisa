import 'package:get_it/get_it.dart';

import 'services/remote_config_service.dart';

final locator = GetIt.instance;
Future setupLocator() async {
  var remoteConfigService = await RemoteConfigService.getInstance();
  await remoteConfigService.initialise();
  locator.registerSingleton(remoteConfigService);
}
