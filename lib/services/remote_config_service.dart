import 'package:firebase_remote_config/firebase_remote_config.dart';

const String _DropboxAppKey = "DROPBOX_KEY";
const String _DropboxAppSecret = "DROPBOX_SECRET";
const String _DropboxAppToken = "DROPBOX_ACCESS_TOKEN";

class RemoteConfigService {
  final RemoteConfig _remoteConfig;
  final defaults = <String, dynamic>{
    _DropboxAppKey: 'appkey',
    _DropboxAppSecret: 'secret',
    _DropboxAppToken: 'token',
  };

  static RemoteConfigService _instance;
  static Future<RemoteConfigService> getInstance() async {
    if (_instance == null) {
      _instance = RemoteConfigService(
        remoteConfig: await RemoteConfig.instance,
      );
    }

    return _instance;
  }

  RemoteConfigService({RemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  String get dropboxAppKey => _remoteConfig.getString(_DropboxAppKey);
  String get dropboxAppSecret => _remoteConfig.getString(_DropboxAppSecret);
  String get dropboxAppToken => _remoteConfig.getString(_DropboxAppToken);

  Future initialise() async {
    print('[CONFIG] trying to get configs');
    try {
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } on FetchThrottledException catch (e) {
      print('Remote config fetch throttled: $e');
    } catch (e) {
      print(
          'Unable to fetch remote config. Cached or default values will be used');
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.fetch();
    await _remoteConfig.activateFetched();
  }
}
