import 'package:darshit_practical_29_03/Screens/Add_Data/view/adddata_view.dart';
import 'package:darshit_practical_29_03/Screens/ToDo/bindings/todo_binding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Screens/Add_Data/bindings/adddata_binding.dart';
import '../Screens/Splash/bindings/splash_bindings.dart';
import '../Screens/Splash/view/splash_view.dart';
import '../Screens/ToDo/view/todo_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: _Paths.TODO,
      page: () => ToDoView(),
      binding: ToDoBindings(),
    ),
    GetPage(
      name: _Paths.ADDDATA,
      page: () => AddDataView(),
      binding: AddDataBindings(),
    ),
  ];
}
