import 'dart:io';
import 'package:flibrary/const/enum.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceModel extends ChangeNotifier {
  late SharedPreferences _storage;
  Directory? dir;
  List<String> files = [];

  DeviceModel() {
    _initStorage();
  }

  _initStorage() async {
    _storage = await SharedPreferences.getInstance();
    await _updateSourcePath();

    _filesStreaming();
  }

  _updateSourcePath([String? path]) async {
    if (path != null) {
      await _storage.setString('deviceSourcePath', path);
      dir = Directory(path);
    } else {
      final savedPath = _storage.getString('deviceSourcePath');
      dir = savedPath != null ? Directory(savedPath) : null;
    }

    if (dirSetted) {
      await getFilesList();
    }
  }

  get dirSetted {
    return dir != null;
  }

  chooseSourcePath() async {
    final path = await FilePicker.platform.getDirectoryPath();
    await _updateSourcePath(path);
  }

  getFilesList() async {
    //TODO: Android unsupported files, and don't listen them in directory
    files = await dir!
        .list()
        .where((event) =>
            supportedFileTypes.any((type) => event.path.endsWith(type)))
        .map((event) => event.path)
        .toList();
    notifyListeners();
  }

  _filesStreaming() {
    dir!
        .watch()
        .where((event) =>
            supportedFileTypes.any((type) => event.path.endsWith(type)))
        .listen((event) {
      if (event is FileSystemDeleteEvent) {
        files.removeWhere((file) => file == event.path);
      } else if (event is FileSystemModifyEvent &&
          event.contentChanged &&
          files.last != event.path) {
        // TODO: On linux FileSystemModifyEvent fire two times
        files.add(event.path);
      }
      notifyListeners();
    });
  }
}

final deviceProvider = ChangeNotifierProvider((ref) => DeviceModel());
