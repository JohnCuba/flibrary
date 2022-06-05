String trimProtocolFromPath(String rawPath) {
  return rawPath.startsWith('/opds')
      ? rawPath.replaceFirst('/opds', '')
      : rawPath;
}
