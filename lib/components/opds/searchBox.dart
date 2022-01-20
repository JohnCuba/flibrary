import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key, required this.onSubmit}) : super(key: key);
  final void Function(String)? onSubmit;

  @override
  build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          decoration: const InputDecoration(
            labelText: 'Введите название книги или имя автора'
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: onSubmit,
        ),
      )
    );
  }
}