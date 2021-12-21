import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class GetDirectoryModal extends StatelessWidget {
  const GetDirectoryModal({Key? key}) : super(key: key);

  _pickDirectory() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    print(selectedDirectory);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Выбери устройство'),
      content: const Text(
          'Подключи устройство и выбери папку на нем, в котором лежат книги'),
      actions: [
        TextButton(
            onPressed: _pickDirectory, child: const Text('Выбрать папку'))
      ],
    );
  }
}
