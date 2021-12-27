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
      child: Gallery(
        children: deviceState.files.map((e) => BookPreview(file: e)).toList(),
      ),
    );
  }
}
