import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/bookPreview.dart';
import 'package:flibrary/components/configDevice.dart';
import 'package:flibrary/stores/device.dart';

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
            padding: const EdgeInsets.all(16),
            children: deviceState.files.map((e) => BookPreview(file: e)).toList(),
          ) 
          : const Center(
            child: ConfigDevice(),
          ),
      ),
    );
  }
}
