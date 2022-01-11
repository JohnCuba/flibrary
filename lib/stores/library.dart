import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class LibraryModel extends ChangeNotifier {
  late SharedPreferences? _storage;
  final http.Client _client = http.Client();

  LibraryModel() {
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

  set uri(String newUri) {
    _updateStore('libraryUri', newUri);
  }

  Future<http.StreamedResponse?> fetchFromLibrary([String? path]) async {
    Uri? parsedUri = uri.isNotEmpty ? Uri.parse(uri) : null;
    if (parsedUri != null) {
      http.Request request = http.Request(
          'GET', path != null ? parsedUri.resolve('.$path') : parsedUri);
      if (headers.isNotEmpty) {
        json.decode(headers).forEach((key, value) {
          request.headers[key] = value;
        });
      }
      return await _client.send(request);
    }
    return null;
  }
}

final libraryProvider = ChangeNotifierProvider((ref) => LibraryModel());
