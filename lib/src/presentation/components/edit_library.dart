import 'package:flibrary/src/domain/controllers/catalogs_meta.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class EditLibraryForm extends StatefulWidget {
  const EditLibraryForm({super.key});

  @override
  EditLibraryFormState createState() {
    return EditLibraryFormState();
  }
}

class EditLibraryFormState extends State<EditLibraryForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> _headings = [];
  final catalogController = Get.find<CatalogsMetaController>();

  void addHeading() {
    setState(() {
      _headings.add('heading_${_headings.length}');
    });
  }

  onAddLibrary() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      String url = _formKey.currentState!.value.entries
          .firstWhere((element) => element.key == 'url')
          .value;
      Map<String, String> headers = {};
      _formKey.currentState!.value.entries
          .where((element) =>
              element.key.startsWith('heading_') &&
              !element.key.endsWith('_value'))
          .forEach((name) {
        headers[name.value] = _formKey.currentState!.value.entries
            .firstWhere((element) => element.key == '${name.key}_value')
            .value;
      });
      catalogController.saveCatalog(url, headers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: ListView(
          children: [
            const Text('Добавь новую библиотеку'),
            FormBuilderTextField(
              name: 'url',
              decoration: const InputDecoration(
                labelText: 'Адрес',
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Column(
                        children: _headings
                            .map((key) => Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                        child: FormBuilderTextField(
                                      name: key,
                                    )),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Expanded(
                                        child: FormBuilderTextField(
                                      name: '${key}_value',
                                    ))
                                  ],
                                ))
                            .toList())),
                TextButton(onPressed: addHeading, child: const Text('Добавить'))
              ],
            ),
            const SizedBox(height: 50),
            TextButton(onPressed: onAddLibrary, child: const Text('Сохранить'))
          ],
        ));
  }
}
