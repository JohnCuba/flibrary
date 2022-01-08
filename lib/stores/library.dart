import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class LibraryModel extends ChangeNotifier {
  late SharedPreferences _storage;
  Uri _uri = Uri.parse('http://opds.oreilly.com/opds/');
  final Map<String, String> _headers = {};
  final http.Client _client = http.Client();

  LibraryModel() {
    _initStorage();
  }

  _initStorage() async {
    _storage = await SharedPreferences.getInstance();
    _updateStore();
  }

  _updateStore([String? key, String? value]) {
    if (key != null && value != null) {
      _storage.setString(key, value);
    } else {
      uri = _storage.getString('libraryUri') ?? '';
      headers = _storage.getString('libraryHeaders') ?? '';
    }
    notifyListeners();
  }

  String get headers {
    return jsonEncode(_headers);
  }

  set headers(String value) {
    Map<String, dynamic> rawMap = json.decode(value.isNotEmpty ? value : '{}');
    rawMap.forEach((key, value) {
      _headers[key] = value.toString();
    });
    _updateStore('libraryHeaders', headers);
  }

  String get uri {
    return _uri.toString();
  }

  set uri(String newUri) {
    _uri = Uri.parse(newUri).normalizePath();
    _updateStore('libraryUri', newUri);
  }

  Future<http.Response> fetchFromLibrary([String? path]) async {
    return await _client
      .get(path != null ? _uri.resolve('.$path') : _uri, headers: _headers);
  }
}

final libraryProvider = ChangeNotifierProvider((ref) => LibraryModel());