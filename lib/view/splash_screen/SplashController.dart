import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/RouteHelper.dart';
import '../../utils/injection.dart';
import '../../utils/local_storage.dart';


class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> opacity;
  late Animation<double> scale;
  Timer? _timer;

  static const _duration = Duration(milliseconds: 1200);
  static const _splashDelay = Duration(seconds: 3);

  @override
  void onInit() {
    super.onInit();
    animController = AnimationController(vsync: this, duration: _duration);
    opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animController,
        curve: const Interval(0, 0.6, curve: Curves.easeOut),
      ),
    );
    scale = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(
        parent: animController,
        curve: const Interval(0, 0.6, curve: Curves.easeOutCubic),
      ),
    );
    animController.forward();

    _timer = Timer(_splashDelay, () {
      final isLogin =
          DI<MyLocalStorage>().getBoolValue(DI<MyLocalStorage>().isLogin);
      if (isLogin) {
        //Get.offAllNamed(DI<RouteHelper>().getHomeTabScreen());
      } else {
        Get.offAllNamed(DI<RouteHelper>().getSelectUserScreen());
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    animController.dispose();
    super.onClose();
  }
}
