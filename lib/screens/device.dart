import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../components/bookPreview.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({Key? key}) : super(key: key);

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  late String _directoryPath;
  late List<FileSystemEntity> _books;

  @override
  void initState() {
    _directoryPath = '';
    _books = [];
    super.initState();
  }

  _pickDirectory() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    Directory directory = Directory(selectedDirectory ?? '');

    setState(() {
      _directoryPath = selectedDirectory ?? '';
      _books = directory.listSync(recursive: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          leading: IconButton(
            icon: Icon(_directoryPath.isNotEmpty
                ? Icons.devices_outlined
                : Icons.device_unknown_outlined),
            onPressed: _pickDirectory,
          ),
          title: Text(_directoryPath.isNotEmpty
              ? _directoryPath
              : 'Выбери папку с книгами на устройстве'),
        ),
        ..._books.map((e) => BookPreview(title: e.path)).toList()
      ],
    );
  }
}
