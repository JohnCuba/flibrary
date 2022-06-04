import 'package:flibrary/src/domain/controllers/local_library.controller.dart';
import 'package:flibrary/src/presentation/components/directory_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/books_list.dart';

class LocalLibraryScreen extends StatelessWidget {
  LocalLibraryScreen({Key? key}) : super(key: key);
  final localLibraryController = Get.find<LocalLibraryController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => DirectoryInput(
              value: localLibraryController.sourceDirectory.value,
              onChange: localLibraryController.writeSourceDirectory,
            )),
        Expanded(child: BooksList(controller: localLibraryController))
      ],
    );
  }
}
