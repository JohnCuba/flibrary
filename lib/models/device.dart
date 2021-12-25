import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class DeviceModel extends ChangeNotifier {
  String sourcePath = '';
  late List<FileSystemEntity> files = [];

  updateSourcePath() async {
    sourcePath = await FilePicker.platform.getDirectoryPath() ?? '';
    getFilesList();
    notifyListeners();
  }

  getFilesList() {
    //TODO: Android unsupported files, and don't listen them in directory
    files =
        Directory(sourcePath).listSync(recursive: true).map((e) => e).toList();
  }
}
