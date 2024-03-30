import 'package:darshit_practical_29_03/Screens/Add_Data/controller/adddata_controller.dart';
import 'package:darshit_practical_29_03/Utils/ConsoleLog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Model/TodoModel.dart';
import '../../../Utils/Colors.dart';
import '../../../Utils/CustomWidget.dart';
import '../../../Utils/Height_Width.dart';
import '../../../Utils/Strings.dart';
import '../../../Utils/bounce_widget.dart';
import '../../../routes/app_pages.dart';
import '../controller/todo_controller.dart';

class ToDoView extends StatelessWidget {
  ToDoView({super.key});

  var controller = Get.put(ToDoController());
  var addController = Get.put(AddDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: 'Todo List',
          textColor: whiteColor,
          fontSize: 25,
        ),
        actions: [
          GetBuilder<ToDoController>(
            id: 'drop',
            builder: (controller) => Row(
              children: [
                DropdownButton<String>(
                  icon: const Icon(
                    Icons.filter_alt,
                    color: whiteColor,
                  ),
                  underline: SizedBox.shrink(),
                  hint: CommonText(
                    text: controller.selectedCategory.value,
                    textColor: Colors.white,
                  ),
                  items: addController.category.value.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: CommonText(
                        text: value,
                        textColor: Colors.black,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedCategory.value = value!;
                    controller.getCategory(
                        value: controller.selectedCategory.value);
                    controller.update(['drop']);
                  },
                ),
                controller.selectedCategory.value != 'Select Category'
                    ? Bouncing(
                  onPress: () {
                    controller.selectedCategory.value='Select Category';
                    controller.getList();
                    controller.update();
                  },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CommonText(
                            text: 'Clear',
                            textColor: whiteColor,
                          ),
                      ),
                    )
                    : shrink,
              ],
            ),
          ),
          width20,
        ],
      ),
      body: GetBuilder<ToDoController>(builder: (context) {
        return FutureBuilder<List<TodoModel>>(
          future: controller.todoList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final items = snapshot.data ?? <TodoModel>[];
              controller.isCompletedList.value =
                  List.generate(items.length, (index) => false).toList();
              Console.Log(
                  'CheckBoxValue', controller.isCompletedList.value.length);
              return SizedBox(
                child: items.isEmpty
                    ? const Center(
                        child: Text(noTodoList),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15),
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) => Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(2, 1),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                height10,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonText(
                                            text:
                                                'Name : ${items[index].title}',
                                            fontSize: 16,
                                          ),
                                          height5,
                                          CommonText(
                                            softWrap: true,
                                            maxLine: 1,
                                            textOverflow: TextOverflow.ellipsis,
                                            text:
                                                'Category: ${items[index].category}',
                                            fontSize: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                    CommonText(
                                      text: 'Date : ${items[index].date}',
                                      fontSize: 16,
                                    ),
                                  ],
                                ),
                                height15,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GetBuilder<ToDoController>(
                                      id: 'check',
                                      builder: (controller) =>
                                          items[index].isUpdate == 'true'
                                              ? CommonText(
                                                  text: 'Completed',
                                                  textColor: Colors.green,
                                                )
                                              : Checkbox(
                                                  value: controller
                                                      .isCompletedList
                                                      .value[index],
                                                  onChanged: (bool? value) {
                                                    controller.isCompletedList
                                                        .value[index] = value!;
                                                    Console.Log(
                                                        'CheckBoxValue',
                                                        controller
                                                            .isCompletedList
                                                            .value[index]);
                                                    addController.addUpdateTodo(
                                                        isUpdate: true,
                                                        id: items[index].id,
                                                        isUpdated: true);
                                                    // controller
                                                    //     .update(['check']);
                                                  },
                                                ),
                                    ),
                                    width10,
                                    Bouncing(
                                        onPress: () {
                                          addController.nameController.value
                                              .text = items[index].title;
                                          addController.dateController.value
                                              .text = items[index].date;
                                          addController.selectedCategory.value =
                                              items[index].category;
                                          Get.toNamed(Routes.ADDDATA,
                                              arguments: {
                                                'isUpdate': true,
                                                'id': items[index].id,
                                              });
                                        },
                                        child: const Icon(Icons.edit)),
                                    width10,
                                    Bouncing(
                                      onPress: () async {
                                        await controller.handler
                                            .deleteTodo(items[index].id);
                                        showSnackBar(
                                          isError: false,
                                          message: todoDelete,
                                        );
                                        controller.onRefresh();
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                height10,
                              ],
                            ),
                          ),
                        ),
                      ),
              );
            }
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: whiteColor),
          onPressed: () {
            Get.toNamed(Routes.ADDDATA, arguments: {
              'isUpdate': false,
            });
          }),
    );
  }
}
