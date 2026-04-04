import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../view/Select_User_Screen.dart';
import '../view/splash_screen/SplashController.dart';
import '../view/splash_screen/SplashScreen.dart';


class RouteHelper{

  String splashscreen = "/Splashscreen";
  String selectUserScreen = "/SelectUserScreen";






  String getSplashscreen() => splashscreen;
  String getSelectUserScreen() => selectUserScreen;






List<GetPage> get routes =>[
  GetPage(
    name: splashscreen,
    page: () => SplashScreen(),
    binding: BindingsBuilder(
            () => Get.lazyPut<SplashController>(() => SplashController())),
  ),
  GetPage(name: selectUserScreen, page: () => SafeArea(child: SelectUserScreen()),),


];

}