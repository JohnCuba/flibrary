import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/bookPreview.dart';
import 'package:flibrary/providers/device.dart';

class DeviceScreen extends ConsumerWidget {
  const DeviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceState = ref.watch(deviceProvider);

    return Container(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: min(MediaQuery.of(context).size.width, 1024),
        child: deviceState.dirSetted 
          ? ListView(
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
      ),
    );
  }
}
