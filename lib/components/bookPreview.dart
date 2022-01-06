import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flibrary/stores/book.dart';

class BookPreview extends ConsumerWidget {
  const BookPreview({Key? key, required this.file}) : super(key: key);

  final String file;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookProvider(file));

    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(book.title ?? ''),
        subtitle: Text(book.author ?? ''),
        trailing: IconButton(
                    splashRadius: 15,
                    icon: const Icon(Icons.delete),
                    onPressed: book.deleteBook,
                  )),
    );
  }
}
