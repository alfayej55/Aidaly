import 'dart:convert';

import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/service/api_client.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/utils/enamdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../Utils/app_constants.dart';
import '../../../../helpers/prefs_helper.dart';
import '../../../../helpers/push_notification_helpers.dart';
import '../../../../service/api_check.dart';
import '../../../../views/base/show_toast.dart';

class SignInControllar extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController forgotEmailCtrl = TextEditingController();
  TextEditingController newPassSetCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();

  var loading = false.obs;
  final rxRequestStatus = Status.shopper.obs;

  /// ShopperModel SignIn

  void shopperSignIn() async {
    loading.value = true;
    /// Fcm Tolen Genaret
    //NotificationHelper.getFcmToken();
    var fcmToken=await PrefsHelper.getString(AppConstants.fcmToken);


    print('FCM>>>>>>>$fcmToken');

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
        Get.toNamed(AppRoutes.homeScreen);
      } else {
        Fluttertoast.showToast(msg: 'User Not Found');
      }
      loading.value = false;
      update();
    } else {
      Fluttertoast.showToast(msg: response.body['message']);
      ApiChecker.checkApi(response);
      loading.value = false;
      update();
    }
  }

  /// ShopperModel Forgot Password

  void shopperForgotPass() async {
    loading.value = true;
    Map<String, dynamic> body = {'email': forgotEmailCtrl.text};
    var headers = {'Content-Type': 'application/json'};
    Response response = await ApiClient.postData(
        ApiConstant.shopperforgotpasswordEndPoint, jsonEncode(body),
        headers: headers);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);
      Get.toNamed(AppRoutes.forgotPassOtpScreen,
          arguments: forgotEmailCtrl.text);
      loading.value = false;
      update();
    } else {
      ApiChecker.checkApi(response);
      loading.value = false;
      update();
    }
  }

  /// ShopperModel Forgoty Otp Verification

  var verificationLoading = false.obs;
  void shopperForgotOtpVerification(String email, String otp) async {
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

      Get.toNamed(AppRoutes.setNewPasswordScreen);
      verificationLoading.value = false;
      update();
    } else {
      ApiChecker.checkApi(response);
      verificationLoading.value = false;
      update();
    }
  }

  /// ShopperModel Set New password
  var setPasswordLoading = false.obs;
  void shopperSetNewPassword() async {
    setPasswordLoading.value = true;
    Map<String, dynamic> body = {
      'email': forgotEmailCtrl.text,
      'password': newPassSetCtrl.text
    };
    Response response = await ApiClient.postData(
        ApiConstant.shopperChangeEndPoint, jsonEncode(body));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);
      forgotEmailCtrl.clear();
      newPassSetCtrl.clear();
      Get.offAllNamed(AppRoutes.loginScreen);
      setPasswordLoading.value = false;
      update();
    } else {
      print('Error Chrck>>${response.body}');
      ApiChecker.checkApi(response);
      setPasswordLoading.value = false;
      update();
    }
  }



  /// Google Login







}
