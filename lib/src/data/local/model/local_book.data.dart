import 'dart:io';

import 'package:epubx/epubx.dart';
import 'package:flibrary/src/config/supported_extensions.dart';
import 'package:flibrary/src/domain/model/local_book.dart';
import 'package:path/path.dart' as p;

class LocalBookData {
  static Future<LocalBook> fromLocal(String path) async {
    switch (_parseExtension(path)) {
      case SupportedExtensions.epub:
        return await _parseEpub(path);
      // case SupportedExtensions.fb2:
      //   return _parseFb2();
    }
  }

  static SupportedExtensions _parseExtension(String path) {
    return SupportedExtensions.values.firstWhere((element) =>
        element.toString() ==
        'SupportedExtensions.${p.extension(path).substring(1)}');
  }

  static Future<LocalBook> _parseEpub(String path) async {
    var book = await EpubReader.openBook(File(path).readAsBytes());
    return LocalBook(
        path: path,
        book: book,
        title: book.Title ??
            path.substring(path.lastIndexOf('/'), path.lastIndexOf('.')),
        author: book.Author ?? 'Не подписан',
        delete: File(path).delete,
        getCover: book.readCover);
  }
}
