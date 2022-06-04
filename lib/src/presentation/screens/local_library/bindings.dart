import 'package:flibrary/src/domain/controllers/local_library.controller.dart';
import 'package:get/get.dart';

class LocalLibraryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocalLibraryController());
  }
}
