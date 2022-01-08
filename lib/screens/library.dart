import 'package:flibrary/components/opds/opds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flibrary/stores/library.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref) {
    final libraryState = ref.watch(libraryProvider);

    return Opds();
  }
}
