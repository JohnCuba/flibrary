import 'package:flibrary/src/domain/controllers/catalog.controller.dart';
import 'package:flibrary/src/presentation/components/spinner.dart';
import 'package:flibrary/src/presentation/components/catalog.dart';
import 'package:flibrary/src/presentation/components/edit_library.dart';
import 'package:flibrary/src/domain/controllers/catalogs_meta.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogScreen extends StatelessWidget {
  CatalogScreen({Key? key}) : super(key: key);
  final catalogsMetaController = Get.find<CatalogsMetaController>();
  final catalogController = Get.find<CatalogController>();
  String? get id => Get.routing.args?['id'];

  @override
  Widget build(BuildContext context) {
    catalogsMetaController.updateId(id);
    catalogController.updateMeta(catalogsMetaController.current);

    if (id == null) {
      return const EditLibraryForm();
    }
    return Obx(
        () => catalogController.page == null ? const Spinner() : Catalog());
  }
}
