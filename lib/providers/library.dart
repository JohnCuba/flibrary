import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flibrary/models/library.dart';

final libraryProvider = ChangeNotifierProvider((ref) => LibraryModel());
