import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/gallery.dart';
import '../components/bookPreview.dart';
import 'package:flibrary/providers/device.dart';

class DeviceScreen extends ConsumerWidget {
  const DeviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceState = ref.watch(deviceProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: deviceState.dirSetted 
        ? Gallery(
          children: deviceState.files.map((e) => BookPreview(file: e)).toList(),
        ) 
        : Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                splashRadius: 16,
                icon: Icon(deviceState.dirSetted
                    ? Icons.devices_outlined
                    : Icons.device_unknown_outlined),
                onPressed: deviceState.chooseSourcePath,
              ),
              Text(deviceState.dirSetted
                  ? deviceState.dir!.path
                  : 'Выбери папку с книгами на устройстве'),
            ],
          ),
        ),
    );
  }
}
