import 'dart:math';
import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  const Gallery({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        crossAxisCount: max(MediaQuery.of(context).size.width ~/ 256, 1),
        physics: const ScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        children: children);
  }
}
