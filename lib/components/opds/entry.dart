import 'package:flibrary/components/opds/book.dart';
import 'package:flibrary/components/opds/section.dart';
import 'package:flibrary/const/enum.dart';
import 'package:flibrary/stores/opds/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xml/xml.dart';

class Entry extends ConsumerWidget {
  final XmlElement element;
  final Function onClick;
  const Entry({Key? key, required this.element, required this.onClick}) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref) {
    final entryState = ref.watch(entryProvider(element));

    switch(entryState.kind) {
      case OpdsEntryKind.book:
        return GestureDetector(
          child: Book(
            title: entryState.title,
            author: entryState.subtitle,
            cover: entryState.cover,
          ),
        );

      case OpdsEntryKind.other:
        return GestureDetector(
          onTap: () {
            onClick(entryState.path);
          },
          child: Section(
            title: entryState.title,
            subtitle: entryState.subtitle
          ),
        );
    }
  }
}