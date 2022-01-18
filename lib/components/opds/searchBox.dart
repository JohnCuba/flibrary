import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key, required this.onSubmit}) : super(key: key);
  final void Function(String)? onSubmit;

  @override
  build(BuildContext context) {
    return Card(
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: onSubmit,
      ),
    );
  }
}