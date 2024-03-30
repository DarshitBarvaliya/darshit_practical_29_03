import 'dart:async';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  var tokens;

  @override
  void onInit() {
    loadApp();
    super.onInit();
  }

  void loadApp() {
    Timer(
      const Duration(seconds: 3),
      () {
        Get.offAllNamed(Routes.TODO);
      },
    );
  }
}
