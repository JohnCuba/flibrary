import 'package:flibrary/stores/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownloadsModel extends ChangeNotifier {
  final String uri;
  final String headers;

  DownloadsModel({required this.uri, required this.headers});
}

final downloadsProvider = ChangeNotifierProvider((ref) => DownloadsModel(
      uri: ref.watch(settingsProvider).uri,
      headers: ref.watch(settingsProvider).headers,
    ));
