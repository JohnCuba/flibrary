import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookPreview extends StatelessWidget {
  const BookPreview({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Text(title)],
      ),
    );
  }
}
