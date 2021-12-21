import 'package:flutter/material.dart';
import '../components/getDirectoryModal.dart';

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key}) : super(key: key);

  _showInitDialog(context) => () => showDialog(
      context: context,
      builder: (BuildContext context) => const GetDirectoryModal());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Device'),
          TextButton(
              onPressed: _showInitDialog(context),
              child: const Text('pick device'))
        ],
      ),
    );
  }
}
