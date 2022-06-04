import 'package:flibrary/src/config/supported_extensions.dart';

bool checkEventFileExtension(dynamic event) =>
    SupportedExtensions.values.any((type) => event.path
        .endsWith(type.toString().replaceFirst('SupportedExtensions.', '')));
