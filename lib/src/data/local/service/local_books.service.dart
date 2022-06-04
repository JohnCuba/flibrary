import 'dart:io';

class LocalBooksService {
  late Directory directory;
  late final bool Function(dynamic) eventsFilter;
  late final void Function(List<String>) onGetPathList;
  late final void Function(FileSystemEvent event) onGetSystemEvent;

  LocalBooksService({
    required String path,
    required this.eventsFilter,
    required this.onGetPathList,
    required this.onGetSystemEvent,
  });

  _initFilesList() async {
    final events = await directory
        .list()
        .where(eventsFilter)
        .map((event) => event.path)
        .toList();

    onGetPathList(events);
  }

  initFilesStreaming() {
    directory.watch().where(eventsFilter).listen(onGetSystemEvent);
  }

  changePath(String path) {
    directory = Directory(path);
    _initFilesList();
  }
}
