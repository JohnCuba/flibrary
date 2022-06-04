import 'dart:io';
import 'package:flibrary/src/data/local/model/local_book.data.dart';
import 'package:flibrary/src/data/local/service/local_books.service.dart';
import 'package:flibrary/src/domain/model/local_book.dart';
import 'package:flibrary/src/utils/check_event_file_extension.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalLibraryController extends GetxController {
  final _storageKey = 'sourceDirectory';
  final sourceDirectory = Rxn<String>();
  final _storage = GetStorage();
  final books = <LocalBook>[].obs;
  late final LocalBooksService _localBooksService;

  LocalLibraryController() {
    _localBooksService = LocalBooksService(
        path: '',
        eventsFilter: checkEventFileExtension,
        onGetPathList: _initBooksList,
        onGetSystemEvent: _handleSystemFileEvent);
    _updateSourceDirectory();
  }

  _updateSourceDirectory() {
    sourceDirectory(_storage.read(_storageKey));
    _localBooksService.changePath(sourceDirectory.value ?? '');
  }

  Stream<LocalBook> _parseEvents(List<String> paths) async* {
    int index = 0;
    while (index < paths.length) {
      yield await LocalBookData.fromLocal(paths[index]);
      index++;
    }
  }

  _initBooksList(List<String> paths) {
    if (paths.isEmpty) {
      books.assignAll([]);
    } else {
      final stream = _parseEvents(paths);

      stream.listen((book) {
        books.assignAll([...books, book]);
      }).onDone(() {
        _localBooksService.initFilesStreaming();
      });
    }
  }

  _handleSystemFileEvent(FileSystemEvent event) async {
    if (event is FileSystemDeleteEvent) {
      books.removeWhere((book) => book.path == event.path);
    } else if (event is FileSystemCreateEvent &&
        books.last.path != event.path) {
      // Prevent doubles in list
      books.assignAll([...books, await LocalBookData.fromLocal(event.path)]);
    }
  }

  writeSourceDirectory(String value) {
    _storage.write(_storageKey, value);
    _updateSourceDirectory();
  }
}
