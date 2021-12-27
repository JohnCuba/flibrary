import 'package:flibrary/providers/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref) {
    final deviceState = ref.watch(deviceProvider);

    return Center(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // TODO: Mark that directory is not choosen
          Row(
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
          )
        ],
      ),
    );
  }
}
