import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LibraryModel extends ChangeNotifier {
  late SharedPreferences _storage;
  String _uri = '';
  Map<String, dynamic> _body = {};

  LibraryModel() {
    _initStorage();
  }

  _initStorage() async {
    _storage = await SharedPreferences.getInstance();
    _updateStore();
  }

  _updateStore([String? key, String? value]) async {
    if (key != null && value != null) {
      await _storage.setString(key, value);
    } else {
      uri = _storage.getString('libraryUri') ?? '';
      body = _storage.getString('libraryBody') ?? '';
    }
    notifyListeners();
  }

  String get body {
    return jsonEncode(_body);
  }

  set body(String newBody) {
    _body = jsonDecode(newBody);
    _updateStore('libraryBody', body);
  }

  String get uri {
    return _uri;
  }

  set uri(String newUri) {
    _uri = newUri;
    _updateStore('libraryUri', uri);
  }
}
