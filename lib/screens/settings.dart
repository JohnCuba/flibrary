import 'dart:math';
import 'package:flibrary/stores/settings.dart';
import 'package:flutter/material.dart';

import 'package:flibrary/components/configDevice.dart';
import 'package:flibrary/components/configLibrary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);

    return Container(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: min(MediaQuery.of(context).size.width, 1024),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const ConfigDevice(),
            ConfigLibrary(),
          ],
        ),
      ),
    );
  }
}
