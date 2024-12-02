
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class showToastMessage {

   //static showMessage(String message) {
  //   return Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0
  //   );
  // }

  static showMessage(String message,) {
    Get.snackbar(
      'Attention',
      message,
      duration: Duration(seconds: 2),
    );
  }

}