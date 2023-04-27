import 'package:flutter/material.dart';
import 'package:foodit/core/theme/app_color.dart';
import 'package:get/get.dart';

errorSnackbar(String? title, String? message) {
  GetSnackBar snackbar = GetSnackBar(
    isDismissible: true,
    dismissDirection: DismissDirection.down,

    titleText: Text(title ?? "Invalid Inputs",
        style: TextStyle(color: AppColor.light.errorColor)),
    messageText: Text(
      message ?? "Please try again with valid data.",
    ),
    icon: Icon(
      Icons.error_outline,
      color: AppColor.light.errorColor,
      size: 28,
    ),
    duration: const Duration(milliseconds: 3000),
    animationDuration: const Duration(milliseconds: 500),
    snackPosition: SnackPosition.BOTTOM,

    // snackStyle: SnackStyle.FLOATING,
    backgroundColor: AppColor.light.white,
    margin: const EdgeInsets.only(
      left: 5,
      right: 5,
      bottom: 5,
    ),
  );
  Get.showSnackbar(snackbar);
}

successSnackBar(String? title, String? message) {
  GetSnackBar snackbar = GetSnackBar(
    titleText: Text(title ?? "Successfully Saved",
        style: TextStyle(
          color: AppColor.light.successColor,
        )),
    messageText: Text(
      message ?? "The data has been successfully saved.",
      style: TextStyle(
        color: AppColor.light.darkGrey,
      ),
    ),
    isDismissible: true,
    duration: const Duration(milliseconds: 3000),

    dismissDirection: DismissDirection.down,
    animationDuration: const Duration(milliseconds: 500),
    snackPosition: SnackPosition.BOTTOM,

    // snackStyle: SnackStyle.FLOATING,
    backgroundColor: Colors.white70,
    margin: const EdgeInsets.only(
      left: 5,
      right: 5,
      bottom: 5,
    ),
  );

  Get.showSnackbar(snackbar);
}
