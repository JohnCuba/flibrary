import 'package:flibrary/models/device.dart';
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
  @override
  void initState() {
    super.initState();
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
            onPressed: deviceState.updateSourcePath,
          ),
          title: Text(deviceState.sourcePath.isNotEmpty
              ? deviceState.sourcePath
              : 'Выбери папку с книгами на устройстве'),
        ),
        ...deviceState.books.map((e) => BookPreview(title: e)).toList()
      ],
    );
  }
}
