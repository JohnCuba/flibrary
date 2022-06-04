import 'package:flibrary/src/domain/model/local_book.dart';
import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  final LocalBook data;

  const Book({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        visualDensity: VisualDensity.comfortable,
        title: Text(data.title),
        subtitle: Text(data.author),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: data.delete,
          splashRadius: 5,
        ),
      ),
    );
  }
}
