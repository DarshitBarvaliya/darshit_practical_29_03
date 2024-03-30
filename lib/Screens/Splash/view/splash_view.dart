
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/CustomWidget.dart';
import '../../../Utils/Height_Width.dart';
import '../controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});

  var controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FlutterLogo(
            size: 50,
          ),
          height20,
          Center(
            child: CommonText(
              text: 'Darshit Practical',
              fontSize: 20,
              textColor: Colors.black,
            ),
          ),
          height20,
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
