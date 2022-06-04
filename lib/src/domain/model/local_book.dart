import 'package:epubx/epubx.dart';

class LocalBook {
  final String path;
  final EpubBookRef book;
  final String title;
  final String author;

  final Future<Image?> Function() getCover;
  final void Function() delete;

  LocalBook(
      {required this.path,
      required this.book,
      required this.title,
      required this.author,
      required this.delete,
      required this.getCover});
}
