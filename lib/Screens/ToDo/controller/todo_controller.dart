import 'package:get/get.dart';

import '../../../DBHelper/dbhelper.dart';
import '../../../Model/TodoModel.dart';

class ToDoController extends GetxController {
  DatabaseHandler handler = DatabaseHandler();
  late Future<List<TodoModel>> todoList;
  var isCompletedList = <bool>[].obs;
  var selectedCategory = 'Select Category'.obs;

  @override
  void onReady() {
    initDatabase();
    super.onReady();
  }

  void initDatabase() async {
    await Future.delayed(Duration.zero);
    await handler.initializeDB();
    todoList = getList();
    update();
  }

  Future<List<TodoModel>> getList() async {
    return await handler.getTodo();
  }

  Future<List<TodoModel>> getByCategory({var value}) async {
    return await handler.getByCategory(value: value);
  }

  void getCategory({var value}) async {
    todoList = getByCategory(value: value);
    update();
  }

  Future<void> onRefresh() async {
    todoList = getList();
    update();
  }
}
