import 'package:get/get.dart';

import '../controller/adddata_controller.dart';

class AddDataBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDataController>(() => AddDataController());
  }
}