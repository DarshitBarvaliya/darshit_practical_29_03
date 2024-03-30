import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../DBHelper/dbhelper.dart';
import '../../../Model/TodoModel.dart';
import '../../../Utils/CustomWidget.dart';
import '../../ToDo/controller/todo_controller.dart';

class AddDataController extends GetxController {
  var nameController = TextEditingController().obs,
      amountController = TextEditingController().obs,
      descriptionController = TextEditingController().obs,
      dateController = TextEditingController().obs,
      timeController = TextEditingController().obs;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var todoController = Get.put(ToDoController());
  var category = [
    "Housing",
    "Childcare",
    "Food",
    "Pets",
    "Savings",
    "Entertainment",
    "Healthcare",
    "Insurance",
    "Personal care",
    "Debt",
    "Gifts",
    "Donations",
    "Clothing",
    "Shopping",
  ].obs;
  var selectedCategory = 'Select Category'.obs;

  void selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.value.text = formatter.format(selectedDate);
      update();
    }
  }

  @override
  void onInit() {
    dateController.value.text = 'Select a date';
    super.onInit();
  }

  void addUpdateTodo({bool? isUpdate, var id, var isUpdated}) async {
    if (isUpdated) {
      await DatabaseHandler()
          .updateIncome(
        TodoModel(
          id: id,
          title: nameController.value.text,
          date: dateController.value.text,
          category: selectedCategory.value,
          isUpdate: 'true',
        ),
      )
          .whenComplete(
        () {
          debugPrint('updated Successfully');
          Get.back();
          nameController.value.clear();
          dateController.value.clear();
          selectedCategory.value = 'Select Category';
          showSnackBar(isError: false, message: 'Todo updated successfully!');
          todoController.onRefresh();
        },
      );
    } else {
      if (nameController.value.text.isEmpty) {
        showSnackBar(isError: true, message: 'Title is Required!');
      } else if (dateController.value.text.isEmpty) {
        showSnackBar(isError: true, message: 'date is Required!');
      } else if (selectedCategory == 'Select Category') {
        showSnackBar(isError: true, message: 'Please select a category');
      } else {
        if (isUpdate!) {
          await DatabaseHandler()
              .updateIncome(
            TodoModel(
              id: id,
              title: nameController.value.text,
              date: dateController.value.text,
              category: selectedCategory.value,
              isUpdate: 'true',
            ),
          )
              .whenComplete(
            () {
              debugPrint('updated Successfully');
              Get.back();
              nameController.value.clear();
              dateController.value.clear();
              selectedCategory.value = 'Select Category';
              showSnackBar(
                  isError: false, message: 'Todo updated successfully!');
              todoController.onRefresh();
            },
          );
        } else {
          await DatabaseHandler()
              .insertIncome(
            TodoModel(
              id: Random().nextInt(50),
              title: nameController.value.text,
              date: dateController.value.text,
              category: selectedCategory.value,
              isUpdate: 'false',
            ),
          )
              .whenComplete(
            () {
              debugPrint('Added Successfully');
              Get.back();
              nameController.value.clear();
              dateController.value.clear();
              selectedCategory.value = 'Select Category';
              showSnackBar(isError: false, message: 'Todo Added successfully!');
              todoController.onRefresh();
            },
          );
        }
      }
    }
  }
}
