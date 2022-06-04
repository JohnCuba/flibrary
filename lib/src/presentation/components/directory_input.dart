import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DirectoryInput extends StatelessWidget {
  final String? value;
  final Function(String) onChange;
  const DirectoryInput({Key? key, this.value, required this.onChange})
      : super(key: key);

  void onChage() async {
    final path = await FilePicker.platform.getDirectoryPath();
    if (path != null) onChange(path);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(value ?? 'Choose location'),
        TextButton(onPressed: onChage, child: const Text('change'))
      ],
    );
  }
}
