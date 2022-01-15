import 'dart:io';
import 'package:epubx/epubx.dart';
import 'package:fb2_parse/fb2_parse.dart';
import 'package:path/path.dart' as p;
import 'package:flibrary/const/enum.dart';

class LocalBook {
  late final String _localPath;
  late SupportedExtensions extension;
  String title = '';
  String author = '';

  LocalBook(this._localPath);

  parseFile() async {
    extension = SupportedExtensions
      .values
      .firstWhere((element) => element.toString() == 'SupportedExtensions.${p.extension(_localPath).substring(1)}');

    switch (extension) {
      case SupportedExtensions.epub:
        await _parseEpub();
        break;
      case SupportedExtensions.fb2:
        _parseFb2();
        break;
    }
  }

  deleteFile() {
    File(_localPath).delete();
  }

  _parseEpub() async {
    var book = await EpubReader.openBook(File(_localPath).readAsBytes());
    title = book.Title ?? '';
    author = book.Author ?? '';
  }

  _parseFb2() async {
    var book = FB2Book(_localPath);
    await book.parse();
    title = book.description.bookTitle ?? '';
    author = book.description.authors?.join(', ') ?? '';
  }
}