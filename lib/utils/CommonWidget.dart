import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'ColorConst.dart';
import 'ImageConst.dart';
import 'StringConst.dart';
import 'injection.dart';

class CommonWidget {
  TextStyle myTextStyle(Color txtColor, double size, FontWeight fw) {
    return TextStyle(
        color: txtColor,
        fontSize: size,
        fontWeight: fw,
        overflow: TextOverflow.ellipsis);
  }

  TextFormField myTextFormField(String hintText,
      {TextEditingController? controller,
      TextInputAction? textInputAction,
      TextInputType? textInputType,
      IconData? icon,
      int? maxLine,
      int? minLine,
      Color? fillColor,
      bool? fill}) {
    return TextFormField(
      controller: controller,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textInputAction: textInputAction,
      keyboardType: textInputType,
      minLines: minLine,
      maxLines: maxLine,
      style: DI<CommonWidget>()
          .myTextStyle(DI<ColorConst>().blackColor, 15.sp, FontWeight.w500),
      decoration: InputDecoration(
        fillColor: fillColor,
          filled: fill,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.7),
              borderSide:
                  BorderSide(color: DI<ColorConst>().gryColor, width: 1.0)),
          hintText: hintText,
          hintStyle: DI<CommonWidget>()
              .myTextStyle(DI<ColorConst>().gryColor, 14.sp, FontWeight.normal),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide:
                  BorderSide(color: DI<ColorConst>().gryColor, width: 1.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide:
                  BorderSide(color: DI<ColorConst>().gryColor, width: 1.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide:
                  BorderSide(color: DI<ColorConst>().gryColor, width: 1.0)),
          contentPadding: EdgeInsets.only(top: 10, left: 10, bottom: 0),
          suffixIcon: Icon(icon, color: DI<ColorConst>().gryColor, size: 25)),
    );
  }

  Widget myButton(String buttonText, void Function() onClick) {
    return SizedBox(
      width: 100.sp,
      height: 28.sp,
      child: ElevatedButton(
        onPressed: onClick,
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(0.0),
            backgroundColor:
                WidgetStatePropertyAll(DI<ColorConst>().colorPrimary)),
        child: Text(
          buttonText,
          style: DI<CommonWidget>()
              .myTextStyle(DI<ColorConst>().blackColor, 16.sp, FontWeight.w400),
        ),
      ),
    );
  }

  AppBar myAppBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: DI<ColorConst>().blackColor,
        ),
      ),
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: DI<ColorConst>().whiteColor,
      actions: [
        InkWell(
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            )),
        InkWell(
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart_outlined),
            ))
      ],
    );
  }

  AppBar myAppBarWithTitle(String title) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: DI<ColorConst>().blackColor,
        ),
      ),
      title: Text(
        title,
        style: DI<CommonWidget>()
            .myTextStyle(DI<ColorConst>().blackColor, 17.sp, FontWeight.w400),
      ),
      elevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: DI<ColorConst>().whiteColor,
    );
  }

  /// Dashboard metric card - simple, clear (Flipkart Seller style)
  Widget dashboardMetricCard(String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: DI<ColorConst>().whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: DI<ColorConst>().blackColor.withOpacity(0.06),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value == "null" ? "0" : value,
            style: myTextStyle(DI<ColorConst>().secondColorPrimary, 20.sp, FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: myTextStyle(DI<ColorConst>().darkGryColor, 12.sp, FontWeight.w400),
          ),
        ],
      ),
    );
  }

  /// Section card for menu groups (Listings, Orders, etc.)
  Widget sectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: DI<ColorConst>().whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: DI<ColorConst>().blackColor.withOpacity(0.06),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Text(
              title,
              style: myTextStyle(DI<ColorConst>().blackColor, 15.sp, FontWeight.w600),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  /// Single menu row for portal / account (clear, tappable)
  Widget menuTile(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        child: SizedBox(
          height: 48,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 22, color: DI<ColorConst>().secondColorPrimary),
              SizedBox(width: 14),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: myTextStyle(DI<ColorConst>().blackColor, 14.sp, FontWeight.w400),
                  ),
                ),
              ),
              Icon(Icons.chevron_right_rounded, size: 22, color: DI<ColorConst>().gryColor),
            ],
          ),
        ),
      ),
    );
  }

  /// Simple app bar (no back button) for main tabs
  PreferredSizeWidget simpleAppBar(String title) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: DI<ColorConst>().whiteColor,
      title: Text(
        title,
        style: myTextStyle(DI<ColorConst>().blackColor, 18.sp, FontWeight.w600),
      ),
    );
  }

  ///To Show Alert Dialog
  Future errorDialog(String errorMsg, Function() onClick) {
    return showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 3,
              insetPadding: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: Container(
                width: 100.w,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DI<StringConst>().alert_txt,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 17.sp,
                    ),
                    Image.asset(
                      DI<ImageConst>().ALERT_ICON,
                      height: 35.sp,
                    ),
                    SizedBox(
                      height: 17.sp,
                    ),
                    Text(
                      errorMsg,
                      maxLines: 10,
                      textAlign: TextAlign.center,
                      style: DI<CommonWidget>().myTextStyle(
                          DI<ColorConst>().blackColor, 15.sp, FontWeight.w500),
                    ),
                    SizedBox(
                      height: 17.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 46.sp),
                      child: DI<CommonWidget>()
                          .myButton(DI<StringConst>().okText, onClick),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

}
