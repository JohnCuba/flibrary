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
    books = Directory(sourcePath)
        .listSync(recursive: false)
        .map((e) => e.toString())
        .toList();
  }
}
