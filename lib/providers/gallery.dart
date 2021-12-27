import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flibrary/models/gallery.dart';

final galleryProvider = ChangeNotifierProvider((ref) => GalleryModel());
