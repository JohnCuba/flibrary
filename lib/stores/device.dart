import 'dart:io';
import 'package:flibrary/const/enum.dart';
import 'package:flibrary/stores/settings.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceModel extends ChangeNotifier {
  String sourcePath;
  Directory? dir;
  List<String> files = [];

  DeviceModel({required this.sourcePath}) {
    _initStorage();
  }

  _initStorage() async {
    await _updateSourcePath();

    _filesStreaming();
  }

  _updateSourcePath([String? path]) async {
    if (path != null) {
      sourcePath = path;
      dir = Directory(path);
    } else {
      dir = sourcePath.isNotEmpty ? Directory(sourcePath) : null;
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

  bool _checkEventFileExtension(dynamic event) =>
      SupportedExtensions.values.any((type) => event.path
          .endsWith(type.toString().replaceFirst('SupportedExtensions.', '')));

  getFilesList() async {
    //TODO: Android unsupported files, and don't listen them in directory
    files = await dir!
        .list()
        .where(_checkEventFileExtension)
        .map((event) => event.path)
        .toList();
    notifyListeners();
  }

  _filesStreaming() {
    dir!.watch().where(_checkEventFileExtension).listen((event) {
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

final deviceProvider = ChangeNotifierProvider(
    (ref) => DeviceModel(sourcePath: ref.watch(settingsProvider).sourcePath));
