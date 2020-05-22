import 'dart:io';
import 'package:falaalgumacoisa/services/file_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../service_locator.dart';

class UploadWidget extends StatefulWidget {
  @override
  _UploadWidget createState() => _UploadWidget();
}

class _UploadWidget extends State<UploadWidget> {
  final FileStorageService _fileStorageService = locator<FileStorageService>();

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
    final String documentsRoot = await _localPath;
    final String filepath = '$documentsRoot/file.wav';

    await _fileStorageService.upload(File(filepath));
  }
}
