import 'package:falaalgumacoisa/services/config_service.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import '../service_locator.dart';

class FileStorageService {
  final ConfigService _configService = locator<ConfigService>();

  Future upload(File file) async {
    String filename = basename(file.path);

    var uri = Uri.parse('https://content.dropboxapi.com/2/files/upload');
    var request = http.Request('POST', uri);
    request.bodyBytes = file.readAsBytesSync();

    var token = _configService.config.dropboxAccessToken;
    print(token);
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'application/octet-stream';
    request.headers['Dropbox-API-Arg'] =
        '{"path": "/voices/$filename","mode": "add","autorename": true,"mute": false,"strict_conflict": false}';

    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }
}
