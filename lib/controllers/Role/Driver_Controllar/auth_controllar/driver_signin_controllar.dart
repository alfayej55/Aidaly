

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../Utils/app_constants.dart';
import '../../../../helpers/prefs_helper.dart';
import '../../../../helpers/push_notification_helpers.dart';
import '../../../../helpers/route.dart';
import '../../../../service/api_check.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_constants.dart';
import '../../../../utils/enamdata.dart';

class DriverSignInControllar extends GetxController{

  TextEditingController emailCtrl=TextEditingController();
  TextEditingController passwordCtrl=TextEditingController();
  TextEditingController forgotEmailCtrl=TextEditingController();

  TextEditingController newPassCtrl=TextEditingController();
  TextEditingController confiramPassCtrl=TextEditingController();

  var loading = false.obs;
  final rxRequestStatus = Status.driver.obs;

  /// Driver Signin
  void driverSignIn() async {
    loading.value = true;

    NotificationHelper.getFcmToken();
    var fcmToken=await PrefsHelper.getString(AppConstants.fcmToken);

    Map<String, dynamic> body = {
      'email': emailCtrl.text,
      'password': passwordCtrl.text,
      "fcmToken" :fcmToken

    };
    var headers = {'Content-Type': 'application/json'};
    Response response = await ApiClient.postData(
        ApiConstant.shopperSignInEndPoint, jsonEncode(body),
        headers: headers);
    if (response.statusCode == 200) {
      var userRole = response.body['data']['attributes']['role'];
      if (userRole == rxRequestStatus.value.name) {

        await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token']);
        await PrefsHelper.setString(AppConstants.userRoles, response.body['data']['attributes']['role']);
        await PrefsHelper.setString(AppConstants.userId, response.body['data']['attributes']['_id']);
        Fluttertoast.showToast(msg: response.body['message']);
        emailCtrl.clear();
        passwordCtrl.clear();
        Get.toNamed(AppRoutes.driversHomeScreen);
      }else {
        Fluttertoast.showToast(msg: 'User Not Found');
      }
      loading.value = false;
      update();
    }

    else {
     // Fluttertoast.showToast(msg: response.body['message']);
      ApiChecker.checkApi(response);
      loading.value = false;
      update();
    }
  }

  /// Driver Forgot Password

  void driverForgotPass() async {
    loading.value = true;
    Map<String, dynamic> body = {'email': forgotEmailCtrl.text};
    var headers = {'Content-Type': 'application/json'};
    Response response = await ApiClient.postData(
        ApiConstant.shopperforgotpasswordEndPoint, jsonEncode(body),
        headers: headers);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);
      Get.toNamed(AppRoutes.driverforgotOtpScreen,
          arguments: forgotEmailCtrl.text);
      loading.value = false;
      update();
    }
    else {
      ApiChecker.checkApi(response);
      loading.value = false;
      update();
    }
  }

  /// Driver Forgoty Otp Verification
  var verificationLoading = false.obs;
  void driverForgotOtpVerification(String email, String otp) async {
    verificationLoading.value = true;
    Map<String, dynamic> body = {'email': email, 'code': otp};
    var headers = {'Content-Type': 'application/json'};
    Response response = await ApiClient.postData(
        ApiConstant.shopperOtpVerificationPoint, jsonEncode(body),
        headers: headers);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);
      print('Body Get:${response.body}');

      // await  PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['attributes']['accessToken']);
      // await PrefsHelper.setString(AppConstants.userId, response.body['data']['attributes']['id']);
      // var token=await  PrefsHelper.getString(AppConstants.bearerToken);

      Get.toNamed(AppRoutes.driverssetNewPasswordScreen);
      verificationLoading.value = false;
      update();
    } else {
      ApiChecker.checkApi(response);
      verificationLoading.value = false;
      update();
    }
  }
  /// Driver Set New password
  var setPasswordLoading = false.obs;

  void driverSetNewPassword() async {
    setPasswordLoading.value = true;

    Map<String, dynamic> body = {
      'email': forgotEmailCtrl.text,
      'password': newPassCtrl.text
    };
    Response response = await ApiClient.postData(
        ApiConstant.shopperChangeEndPoint, jsonEncode(body));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);

      forgotEmailCtrl.clear();
      newPassCtrl.clear();
      Get.toNamed(AppRoutes.driversloginScreen);
      setPasswordLoading.value = false;
      update();
    } else {
      print('Error Chrck>>${response.body}');
      ApiChecker.checkApi(response);
      setPasswordLoading.value = false;
      update();
    }
  }

}