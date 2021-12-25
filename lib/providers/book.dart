import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flibrary/models/book.dart';

final bookProvider = ChangeNotifierProvider.autoDispose
    .family<BookModel, FileSystemEntity>((ref, file) => BookModel(file));
