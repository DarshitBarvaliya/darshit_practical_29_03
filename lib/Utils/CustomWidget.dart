import 'package:darshit_practical_29_03/Screens/ToDo/controller/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Colors.dart';
import 'Height_Width.dart';
import 'Strings.dart';
import 'bounce_widget.dart';

OutlineInputBorder? commonBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(color: Colors.grey),
);

class CommonText extends StatelessWidget {
  String? text;
  Color? textColor;
  double? fontSize;
  int? maxLine;
  TextOverflow? textOverflow;
  bool? softWrap;

  CommonText({
    super.key,
    this.text,
    this.textColor,
    this.fontSize,
    this.maxLine,
    this.textOverflow,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
      ),
      maxLines: maxLine,
      overflow: textOverflow,
      softWrap: softWrap,
    );
  }
}

class CustomButton extends StatelessWidget {
  String? text;
  Function()? onTap;
  Color? color, textColor;
  double? height;

  CustomButton({
    super.key,
    this.text,
    this.onTap,
    this.height = 55,
    this.color = Colors.indigo,
    this.textColor = buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: Get.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: CommonText(
          text: text!,
          textColor: textColor,
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  String? hintText;
  Widget? prefixIcon, suffixIcon;
  TextEditingController? controller;
  bool? isEditable;
  Function()? onTap;
  Function(String)? onChanged;
  TextInputType? keyboardType;
  int? maxLength;
  FocusNode? focusNode;
  Iterable<String>? autofillHints;
  List<TextInputFormatter>? inputFormatters;
  TextInputAction? textInputAction;
  EdgeInsetsGeometry? contentPadding;
  TextCapitalization textCapitalization;

  CustomTextField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.suffixIcon,
    this.isEditable = false,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.textInputAction,
    this.focusNode,
    this.onChanged,
    this.maxLength,
    this.autofillHints,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: isEditable!,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLength: maxLength,
      onChanged: onChanged,
      focusNode: focusNode,
      textCapitalization: textCapitalization,
      autofillHints: autofillHints,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: commonBorder,
        enabledBorder: commonBorder,
        focusedBorder: commonBorder,
        disabledBorder: commonBorder,
        counterStyle: const TextStyle(
          height: double.minPositive,
        ),
        filled: true,
        fillColor: fontColor,
        counterText: "",
        contentPadding: contentPadding,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
    );
  }
}

void showSnackBar({bool? isError, var message}) {
  if (isError!) {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: whiteColor,
            insetPadding: const EdgeInsets.only(left: 20, right: 20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: SizedBox(
              width: 350,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  height15,
                  FlutterLogo(),
                  height5,
                  CommonText(
                    text: 'Error',
                    fontSize: 16,
                  ),
                  height5,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: CommonText(
                      text: message,
                      fontSize: 13,
                    ),
                  ),
                  height10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: CustomButton(
                      text: 'Ok',
                      onTap: Get.back,
                    ),
                  ),
                  height15,
                ],
              ),
            ),
          );
        });
  } else {
    Get.snackbar(
      isError == true ? 'failed' : 'success',
      message,
      icon: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5),
        child: Icon(
          isError == true ? Icons.cancel : Icons.done,
          color: isError == true ? Colors.red : Colors.green,
        ),
      ),
      backgroundColor: whiteColor,
      snackPosition: SnackPosition.BOTTOM,
      borderColor: isError == true ? Colors.red : Colors.green,
      borderWidth: 4,
      colorText: isError == true ? Colors.red : Colors.green,
      duration: Duration(seconds: isError == true ? 3 : 2),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
    );
  }
}
