import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class UploadWidget extends StatefulWidget {
  @override
  _UploadWidget createState() => _UploadWidget();
}

class _UploadWidget extends State<UploadWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _uploadRandomFile,
      icon: Icon(Icons.cloud_upload),
      color: Colors.yellow,
      iconSize: 40,
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  void _uploadRandomFile() async {
    print('[CONFIG] trying to get configs');
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: const Duration(hours: 5));
    await remoteConfig.activateFetched();

    final String documentsRoot = await _localPath;
    final String filepath = '$documentsRoot/file.wav';

    await _asyncFileUpload(
        File(filepath), remoteConfig.getString('DROPBOX_ACCESS_TOKEN'));
  }

  _asyncFileUpload(File file, String token) async {
    String filename = basename(file.path);

    var uri = Uri.parse('https://content.dropboxapi.com/2/files/upload');
    var request = http.Request('POST', uri);
    request.bodyBytes = file.readAsBytesSync();

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
