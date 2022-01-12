import 'package:flibrary/components/loadButton.dart';
import 'package:flibrary/const/enum.dart';
import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  const Book({
    Key? key,
    required this.title,
    this.author,
    this.cover,
    required this.loadState,
    required this.onDownload,
    required this.loadingPercent,
  }) : super(key: key);
  final String title;
  final String? author;
  final LoadState loadState;
  final ImageProvider<Object>? cover;
  final void Function() onDownload;
  final double loadingPercent;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: cover != null ? Image(image: cover!) : null,
        title: Text(title),
        subtitle: author != null ? Text(author!) : null,
        trailing: LoadButton(
          state: loadState,
          onClick: onDownload,
          loadingPercent: loadingPercent
        )
      ),
    );
  }
}