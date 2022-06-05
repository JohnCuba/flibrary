import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatalogHeader extends StatelessWidget {
  final String title;
  final void Function() onClickMainAction;
  final void Function() onClickBack;
  final void Function() onClickHome;
  final void Function(String)? onSearch;
  final String? subtitle;
  const CatalogHeader(
      {Key? key,
      required this.title,
      required this.onClickMainAction,
      required this.onClickBack,
      required this.onClickHome,
      this.onSearch,
      this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vatiousSubtitle = subtitle ?? 'Главная';

    return Column(
      children: [
        Row(children: [
          Expanded(child: Text(title)),
          TextButton(onPressed: onClickMainAction, child: const Text('Remove'))
        ]),
        Row(children: [
          IconButton(
              splashRadius: 10,
              onPressed: onClickBack,
              icon: const Icon(Icons.chevron_left_rounded)),
          IconButton(
              splashRadius: 10,
              onPressed: onClickHome,
              icon: const Icon(Icons.home)),
          Expanded(
              child: Text(subtitle == title ? 'Главная' : vatiousSubtitle)),
          Flexible(
              child: CupertinoSearchTextField(
            onSubmitted: onSearch,
          ))
        ])
      ],
    );
  }
}
