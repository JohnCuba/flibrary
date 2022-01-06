import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flibrary/services/opds.dart';

class LibraryModel extends ChangeNotifier {
  late SharedPreferences _storage;
  String _uri = '';
  final Map<String, String> _headers = {};

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
      body = _storage.getString('libraryHeaders') ?? '';
    }
    Opds(_uri, _headers);
    notifyListeners();
  }

  String get body {
    return jsonEncode(_headers);
  }

  set body(String newBody) {
    Map<String, dynamic> rawMap = json.decode(newBody.isNotEmpty ? newBody : '{}');
    rawMap.forEach((key, value) {
      _headers[key] = value.toString();
    });
    _updateStore('libraryHeaders', body);
  }

  String get uri {
    return _uri;
  }

  set uri(String newUri) {
    _uri = newUri;
    _updateStore('libraryUri', uri);
  }
}

final libraryProvider = ChangeNotifierProvider((ref) => LibraryModel());