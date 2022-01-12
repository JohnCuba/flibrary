const List<String> supportedFileTypes = ['epub'];

enum OpdsEntryKind {
  book,
  other,
}

enum LoadState {
  notStarted,
  pending,
  load,
  done,
}