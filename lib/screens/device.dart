import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import '../components/bookPreview.dart';
import 'package:flibrary/providers/device.dart';

class DeviceScreen extends ConsumerStatefulWidget {
  const DeviceScreen({Key? key}) : super(key: key);

  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends ConsumerState<DeviceScreen> {
  late List<FileSystemEntity> _books;

  @override
  void initState() {
    _books = [];
    super.initState();
    ref.read(deviceProvider);
  }

  _pickDirectory() async {
    final deviceState = ref.read(deviceProvider);
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    deviceState.updateSourcePath(selectedDirectory ?? '');
    Directory directory = Directory(selectedDirectory ?? '');

    setState(() {
      _books = directory.listSync(recursive: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceState = ref.watch(deviceProvider);

    return Column(
      children: [
        AppBar(
          leading: IconButton(
            icon: Icon(deviceState.sourcePath.isNotEmpty
                ? Icons.devices_outlined
                : Icons.device_unknown_outlined),
            onPressed: _pickDirectory,
          ),
          title: Text(deviceState.sourcePath.isNotEmpty
              ? deviceState.sourcePath
              : 'Выбери папку с книгами на устройстве'),
        ),
        ..._books.map((e) => BookPreview(title: e.path)).toList()
      ],
    );
  }
}
