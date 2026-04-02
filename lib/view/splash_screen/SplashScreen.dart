import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/ColorConst.dart';
import '../../utils/ImageConst.dart';
import '../../utils/StringConst.dart';
import '../../utils/injection.dart';
import 'SplashController.dart';


class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<SplashController>();
    final white = DI<ColorConst>().whiteColor;
    final yellow = DI<ColorConst>().colorPrimary;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff003399),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: c.animController,
              builder: (context, child) => Opacity(
                opacity: c.opacity.value,
                child: Transform.scale(
                  scale: c.scale.value,
                  child: child,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        SizedBox(
                          height: 20.sp,
                        ),
                        Text(
                          'Book My Service',
                          style: TextStyle(
                            color: white,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ]
                  ),

                ],
              ),
            ),
            SizedBox(height: 32.sp),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xff003399),
        height: kBottomNavigationBarHeight,
        child: Center(
          child: Text(
            DI<StringConst>().splashTagline,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: white.withOpacity(0.95),
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
