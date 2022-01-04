import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flibrary/providers/library.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref) {
    final galleryState = ref.watch(libraryProvider);

    return ListView(
      children: const [Text('screen is in development')],
    );
  }
}
