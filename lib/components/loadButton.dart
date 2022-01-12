import 'package:flibrary/const/enum.dart';
import 'package:flutter/material.dart';

class LoadButton extends StatelessWidget {
  const LoadButton({
    Key? key,
    required this.state,
    required this.onClick,
    this.loadingPercent,
  }) : super(key: key);

  final LoadState state;
  final double? loadingPercent;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case LoadState.notStarted:
        return IconButton(
            onPressed: onClick,
            icon: const Icon(Icons.download)
          );
      case LoadState.pending:
        return const CircularProgressIndicator(backgroundColor: Colors.white);
      case LoadState.load:
        return CircularProgressIndicator(
            value: loadingPercent,
            backgroundColor: Colors.white,
          );
      case LoadState.done:
        return const Icon(Icons.done);
    }
  }
}