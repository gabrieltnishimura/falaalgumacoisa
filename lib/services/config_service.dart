import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

import 'config_model.dart';

class ConfigService {
  ConfigModel _config;

  Future<ConfigModel> initialise() async {
    return rootBundle.loadStructuredData<ConfigModel>('assets/config.json',
        (jsonStr) async {
      _config = ConfigModel.fromJson(json.decode(jsonStr));
      return _config;
    });
  }

  ConfigModel get config {
    return _config;
  }
}
