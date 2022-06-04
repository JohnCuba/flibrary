import 'package:flibrary/src/domain/controllers/local_library.controller.dart';
import 'package:flibrary/src/presentation/components/book.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BooksList extends StatelessWidget {
  final LocalLibraryController controller;
  const BooksList({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.books.isEmpty) {
        return const Center(
          child: Text('Книги не найлены =('),
        );
      }
      return ListView(
        children: controller.books.map((book) => Book(data: book)).toList(),
      );
    });
  }
}
