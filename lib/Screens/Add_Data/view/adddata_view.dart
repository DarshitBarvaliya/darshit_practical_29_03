import 'package:darshit_practical_29_03/Screens/Add_Data/controller/adddata_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Colors.dart';
import '../../../Utils/CustomWidget.dart';
import '../../../Utils/Height_Width.dart';

class AddDataView extends StatefulWidget {
  AddDataView({super.key});

  @override
  State<AddDataView> createState() => _AddDataViewState();
}

class _AddDataViewState extends State<AddDataView> {
  var controller = Get.put(AddDataController());
  var isUpdate, id;

  @override
  void initState() {
    isUpdate = Get.arguments['isUpdate'] ?? false;
    id = Get.arguments['id'] ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
        title: CommonText(
          text: isUpdate ? 'Update Todo' : "Add Todo",
          textColor: whiteColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height20,
              CommonText(
                text: 'Title:',
                fontSize: 16,
              ),
              height5,
              CustomTextField(
                controller: controller.nameController.value,
                keyboardType: TextInputType.name,
                hintText: 'Enter title',
                textInputAction: TextInputAction.next,
              ),
              height20,
              CommonText(
                text: 'Due Date:',
              ),
              height5,
              Obx(
                () => CustomTextField(
                  onTap: controller.selectDate,
                  isEditable: true,
                  controller: controller.dateController.value,
                  keyboardType: TextInputType.datetime,
                ),
              ),
              height20,
              Row(
                children: [
                  CommonText(
                    text: 'Category:',
                  ),
                  width15,
                  GetBuilder<AddDataController>(
                    builder: (controller) => DropdownButton<String>(
                      hint: CommonText(
                        text: controller.selectedCategory.value,
                        textColor: Colors.black,
                      ),
                      items: controller.category.map((String value) {
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
                        controller.update();
                      },
                    ),
                  ),
                ],
              ),
              height25,
              CustomButton(
                text: isUpdate ? 'Update Todo' : 'Add Todo',
                textColor: whiteColor,
                onTap: () {
                  controller.addUpdateTodo(
                      isUpdate: isUpdate,
                      id: isUpdate ? id : 0,
                      isUpdated: false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
