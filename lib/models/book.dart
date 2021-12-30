import 'dart:io';
// import 'dart:typed_data';
// import 'package:image/image.dart';
import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';

// TODO: Parse image
class BookModel extends ChangeNotifier {
  BookModel(String file) {
    _file = File(file);
    _parseFile();
  }

  late File _file;
  late EpubBookRef? _book;
  bool _loaded = false;
  // late Uint8List? _cover;

  _parseFile() async {
    _book = await EpubReader.openBook(_file.readAsBytes()).whenComplete(() {
      _loaded = true;
      // _parseCover();
      notifyListeners();
    });
  }

  // _parseCover() async {
  //   _cover = await _book!
  //           .readCover()
  //           .then((value) => value ?? Uint8List.fromList(encodePng(value!)))
  //       as Uint8List?;

  //   notifyListeners();
  // }

  void deleteBook() async {
    _file.delete();
  }

  String? get title {
    return _loaded ? _book!.Title : '';
  }

  String? get author {
    return _loaded ? _book!.Author : '';
  }

  // Uint8List? get cover {
  //   return _loaded ? _cover : null;
  // }
}
