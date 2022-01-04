import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flibrary/components/configDevice.dart';
import 'package:flibrary/components/configLibrary.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: min(MediaQuery.of(context).size.width, 1024),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const ConfigDevice(),
            ConfigLibrary(),
          ],
        ),
      ),
    );
  }
}
