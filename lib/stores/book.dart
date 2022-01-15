import 'package:flibrary/lib/localBook.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class BookModel extends ChangeNotifier {
  BookModel(String file) {
    _book = LocalBook(file);
    _parseFile();
  }

  late LocalBook _book;

  _parseFile() async {
    await _book.parseFile();
    notifyListeners();
  }

  void deleteBook() async {
    _book.deleteFile();
  }

  String get title {
    return _book.title;
  }

  String get author {
    return _book.author;
  }
}

final bookProvider = ChangeNotifierProvider
    .autoDispose
    .family<BookModel, String>((ref, file) => BookModel(file));