import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class DeviceModel extends ChangeNotifier {
  String sourcePath = '';
  late List<String> books = [];

  updateSourcePath() async {
    sourcePath = await FilePicker.platform.getDirectoryPath() ?? '';
    getBooksList();
    notifyListeners();
  }

  getBooksList() {
    //TODO: Android unsopported files don't listen in directory
    books = Directory(sourcePath)
        .listSync(recursive: true)
        .map((e) => e.toString())
        .toList();
  }
}
