
import 'package:get/get.dart';

import '../controller/todo_controller.dart';

class ToDoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ToDoController>(() => ToDoController());
  }
}
