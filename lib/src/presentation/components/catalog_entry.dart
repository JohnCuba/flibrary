import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CatalogEntry extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Function? onClick;
  final IconData? icon;
  const CatalogEntry(
      {Key? key, required this.title, this.subtitle, this.onClick, this.icon})
      : super(key: key);

  handleClick() {
    if (onClick != null) {
      onClick!();
    }
  }

  @override
  Widget build(BuildContext context) {
    var subtitleWidget = subtitle != null ? Html(data: subtitle!) : null;
    var trailingWidget =
        onClick != null ? Icon(icon ?? Icons.delete_outline) : null;

    return Card(
      child: ListTile(
        onTap: handleClick,
        visualDensity: VisualDensity.comfortable,
        title: Text(title),
        subtitle: subtitleWidget,
        trailing: trailingWidget,
      ),
    );
  }
}
