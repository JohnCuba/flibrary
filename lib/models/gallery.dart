import 'package:flutter/material.dart';

class GalleryModel extends ChangeNotifier {
  late String uri;
  late Map<String, String> body;

  changeCredentials(String newUri, Map<String, String> newBody) {
    uri = newUri;
    body = newBody;
  }
}
