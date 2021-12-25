import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flibrary/providers/book.dart';

class BookPreview extends ConsumerWidget {
  const BookPreview({Key? key, required this.file}) : super(key: key);

  final FileSystemEntity file;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookProvider(file));

    return Card(
      elevation: 2,
      child: Column(
        children: [
          Expanded(
            child: book.cover != null
                ? Image.memory(book.cover!)
                : const Icon(Icons.book),
          ),
          Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.title ?? ''),
                      Text(book.author ?? ''),
                    ],
                  )),
              Flexible(
                  flex: 1,
                  child: IconButton(
                    splashRadius: 15,
                    icon: const Icon(Icons.delete),
                    onPressed: book.deleteBook,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
