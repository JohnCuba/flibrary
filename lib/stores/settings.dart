import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsModel extends ChangeNotifier {
  late SharedPreferences? _storage;

  SettingsModel() {
    _storage = null;
    _initStorage();
  }

  _initStorage() async {
    _storage = await SharedPreferences.getInstance();
    notifyListeners();
  }

  _updateStore(String key, String value) {
    _storage?.setString(key, value);
    notifyListeners();
  }

  String get headers {
    return _storage?.getString('libraryHeaders') ?? '';
  }

  set headers(String value) {
    _updateStore('libraryHeaders', value);
  }

  String get uri {
    return _storage?.getString('libraryUri') ?? '';
  }

  set uri(String value) {
    _updateStore('libraryUri', value);
  }

  String get sourcePath {
    return _storage?.getString('deviceSourcePath') ?? '';
  }

  set sourcePath(String value) {
    _updateStore('deviceSourcePath', value);
  }
}

final settingsProvider = ChangeNotifierProvider((ref) => SettingsModel());
