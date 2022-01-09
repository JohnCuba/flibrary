import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  const Book({
    Key? key,
    required this.title,
    this.author,
    this.cover,
    required this.onDownload,
  }) : super(key: key);
  final String title;
  final String? author;
  final ImageProvider<Object>? cover;
  final void Function() onDownload;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: cover != null ? Image(image: cover!) : null,
        title: Text(title),
        subtitle: author != null ? Text(author!) : null,
        trailing: IconButton(
          onPressed: onDownload,
          icon: const Icon(Icons.download)
        ),
      ),
    );
  }
}