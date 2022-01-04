import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flibrary/providers/library.dart';

class ConfigLibrary extends ConsumerWidget {
  ConfigLibrary({Key? key}) : super(key: key);
  final _uriController = TextEditingController(text: '');
  final _bodyController = TextEditingController(text: '');

  @override
  build(BuildContext context, WidgetRef ref) {
    final libraryState = ref.watch(libraryProvider);

    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: TextField(
                controller: _uriController,
                decoration: InputDecoration(
                  labelText: libraryState.uri.isNotEmpty 
                    ? libraryState.uri
                    : 'Введите адресс каталога',
                  suffixIcon: IconButton(
                    onPressed: () {
                      libraryState.uri = _uriController.text;
                      _uriController.clear();
                    },
                    icon: const Icon(Icons.save)
                  )
                ),
              )
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: TextField(
                controller: _bodyController,
                decoration: InputDecoration(
                  labelText: libraryState.body.isNotEmpty 
                    ? libraryState.body
                    : 'Введи тело запроса в формате json',
                  suffixIcon: IconButton(
                    onPressed: () {
                      libraryState.body = _bodyController.text;
                      _bodyController.clear();
                    },
                    icon: const Icon(Icons.save)
                  )
                ),
              )
            ),
          ],
        ),
      ],
    );
  }
}