import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

// TODO: Watch for files changes
class DeviceModel extends ChangeNotifier {
  String sourcePath = '';
  late SharedPreferences storage;
  List<FileSystemEntity> files = [];

  DeviceModel() {
    _initStorage();
  }

  _initStorage() async {
    storage = await SharedPreferences.getInstance();
    await _updateSourcePath();
  }

  _updateSourcePath([String? path]) async {
    if (path != null) {
      await storage.setString('deviceSourcePath', path);
      sourcePath = path;
    } else {
      sourcePath = storage.getString('deviceSourcePath') ?? '';
    }

    if (sourcePath.isNotEmpty) {
      await getFilesList();
    }
  }

  chooseSourcePath() async {
    final path = await FilePicker.platform.getDirectoryPath();
    await _updateSourcePath(path);
  }

  getFilesList() async {
    //TODO: Android unsupported files, and don't listen them in directory
    //TODO: Filter unsupported by app files
    files = await Directory(sourcePath).list(recursive: true).toList();
    notifyListeners();
  }
}
