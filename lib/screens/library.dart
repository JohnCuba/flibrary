import 'package:flibrary/components/opds/opds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flibrary/stores/opds/opds.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref) {
    final opdsState = ref.watch(opdsProvider);

    return Flex(
      direction: Axis.vertical,
      children: [
        LinearProgressIndicator(
          value: opdsState.loadingPercent,
          backgroundColor: Colors.white,
        ),
        const Expanded(
          child: Opds()
        )
      ],
    );
  }
}
