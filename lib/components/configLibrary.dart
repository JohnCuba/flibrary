import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flibrary/stores/settings.dart';

class ConfigLibrary extends ConsumerWidget {
  ConfigLibrary({Key? key}) : super(key: key);
  final _uriController = TextEditingController(text: '');
  final _bodyController = TextEditingController(text: '');

  @override
  build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    _uriController.text = settingsState.uri;
    _bodyController.text = settingsState.headers;

    return Column(
      children: [
        Row(
          children: [
            Flexible(
                child: TextField(
              controller: _uriController,
              decoration: InputDecoration(
                  labelText: 'Введите адресс каталога',
                  suffixIcon: IconButton(
                      onPressed: () {
                        settingsState.uri = _uriController.text;
                      },
                      icon: const Icon(Icons.save))),
            )),
          ],
        ),
        Row(
          children: [
            Flexible(
                child: TextField(
              controller: _bodyController,
              decoration: InputDecoration(
                  labelText: 'Введи тело запроса в формате json',
                  suffixIcon: IconButton(
                      onPressed: () {
                        settingsState.headers = _bodyController.text;
                      },
                      icon: const Icon(Icons.save))),
            )),
          ],
        ),
      ],
    );
  }
}
