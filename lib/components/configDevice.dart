import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flibrary/providers/device.dart';

class ConfigDevice extends ConsumerWidget {
  const ConfigDevice({Key? key}) : super(key: key);


  @override
  build(BuildContext context, WidgetRef ref) {
    final deviceState = ref.watch(deviceProvider);

    return Row(
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
    );
  }
}