import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as image;
import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';

class BookModel extends ChangeNotifier {
  BookModel(file) {
    _parseFile(file);
  }

  late EpubBook _book = EpubBook();

  _parseFile(FileSystemEntity file) async {
    final bytes = await File(file.path).readAsBytes();
    _book = await EpubReader.readBook(bytes);

    notifyListeners();
  }

  void deleteBook() {}

  String? get title {
    return _book.Title;
  }

  String? get author {
    return _book.Author;
  }

  Uint8List? get cover {
    return _book.CoverImage != null
        ? Uint8List.fromList(image.encodePng(_book.CoverImage!))
        : null;
  }
}
