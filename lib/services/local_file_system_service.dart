import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalFileSystemService {
  static const String WAV_FORMAT = '.wav';

  Future<File> createNewFileWithExtension(String filename, String ext) async {
    final directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final String filepath = '$path/$filename$ext';
    File tempLocalFile = File(filepath);
    if (await tempLocalFile.exists()) {
      print('[FS] Duplicate file, deleting');
      await tempLocalFile.delete();
    }
    return tempLocalFile;
  }
}
