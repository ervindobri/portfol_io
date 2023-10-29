import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/services.dart';
import 'package:flutter_command/flutter_command.dart';

class DownloadManager {
  late Command<String, void> downloadFile;

  DownloadManager() {
    downloadFile = Command.createAsyncNoResult(downloadAssetFile);
  }

  Future downloadAssetFile(String filePath) async {
    final downloadName = filePath.split('/').last;
    final file = await rootBundle.load(filePath);
    final bytes = file.buffer.asUint8List();
    // Encode our file in base64
    final base64 = base64Encode(bytes);
    // Create the link with the file
    final anchor =
        AnchorElement(href: 'data:application/octet-stream;base64,$base64')
          ..target = 'blank';
    // add the name
    anchor.download = downloadName;
    // trigger download
    document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  }
}
