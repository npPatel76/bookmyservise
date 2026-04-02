import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../view/splash_screen/SplashController.dart';
import '../view/splash_screen/SplashScreen.dart';


class RouteHelper{

  String splashscreen = "/Splashscreen";






  String getSplashscreen() => splashscreen;






List<GetPage> get routes =>[
  GetPage(
    name: splashscreen,
    page: () => SplashScreen(),
    binding: BindingsBuilder(
            () => Get.lazyPut<SplashController>(() => SplashController())),
  ),

];

}