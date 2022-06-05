import 'package:flibrary/src/domain/controllers/catalog.controller.dart';
import 'package:flibrary/src/domain/controllers/catalogs_meta.controller.dart';
import 'package:flibrary/src/presentation/components/catalog_entry.dart';
import 'package:flibrary/src/presentation/components/catalog_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Catalog extends StatelessWidget {
  Catalog({Key? key}) : super(key: key);
  final catalogController = Get.find<CatalogController>();
  final catalogsMetaController = Get.find<CatalogsMetaController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CatalogHeader(
          title: catalogsMetaController.current!.title,
          subtitle: catalogController.page!.title,
          onClickMainAction: catalogsMetaController.remove,
          onClickBack: catalogController.toPrevPage,
          onClickHome: catalogController.toHome,
          onSearch: catalogController.search,
        ),
        Obx(() => Expanded(
                child: ListView(
                    children: catalogController.page!.entries.map((entry) {
              onClick() {
                catalogController
                    .toPage(entry.catalogLink ?? entry.fileLink ?? '');
              }

              return CatalogEntry(
                title: entry.title,
                subtitle: entry.content,
                icon: Icons.navigate_next_rounded,
                onClick: onClick,
              );
            }).toList())))
      ],
    );
  }
}
