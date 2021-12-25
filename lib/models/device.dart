import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class DeviceModel extends ChangeNotifier {
  String sourcePath = '';
  late List<FileSystemEntity> files = [];

  updateSourcePath() async {
    sourcePath = await FilePicker.platform.getDirectoryPath() ?? '';
    await getFilesList();
    notifyListeners();
  }

  getFilesList() async {
    //TODO: Android unsupported files, and don't listen them in directory
    //TODO: Filter unsupported by app files
    files = await Directory(sourcePath).list(recursive: true).toList();
  }
}
