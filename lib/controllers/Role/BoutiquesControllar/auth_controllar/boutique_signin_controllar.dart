import 'dart:convert';

import 'package:aidaly/utils/enamdata.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../Utils/app_constants.dart';
import '../../../../helpers/prefs_helper.dart';
import '../../../../helpers/push_notification_helpers.dart';
import '../../../../helpers/route.dart';
import '../../../../service/api_check.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_constants.dart';

class BoutiqueSignInControllar extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  TextEditingController forgotEmailCtrl = TextEditingController();
  TextEditingController newPassSetCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();


  var loading = false.obs;
  final rxRequestStatus = Status.boutique.obs;
  setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  /// Boutique SignIn

  void boutiqueSignIn() async {
    loading.value = true;

      // NotificationHelper.getFcmToken();

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
      print('kjojadf');
      var userRole = response.body['data']['attributes']['role'];
        print('Roleee>>>>>${userRole}');
      if (userRole == rxRequestStatus.value.name) {
        await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token']);
        await PrefsHelper.setString(AppConstants.userRoles, response.body['data']['attributes']['role']);
        await PrefsHelper.setString(AppConstants.userId, response.body['data']['attributes']['_id']);
        Fluttertoast.showToast(msg: response.body['message']);
        emailCtrl.clear();
        passwordCtrl.clear();
        Get.toNamed(AppRoutes.homeBoutique);
      } else {
        print('gafdsdsfafkj');
        Fluttertoast.showToast(msg: 'User Not Found');
      }
      loading.value = false;
      update();
    } else {
      print('gafdsdsfafkj');
      ApiChecker.checkApi(response);
      loading.value = false;
      update();
    }
  }

  /// Boutique Forgot Password

  void boutiqueForgotPass() async {
    loading.value = true;
    Map<String, dynamic> body = {'email': forgotEmailCtrl.text};
    var headers = {'Content-Type': 'application/json'};
    Response response = await ApiClient.postData(
        ApiConstant.shopperforgotpasswordEndPoint, jsonEncode(body),
        headers: headers);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);
      Get.toNamed(AppRoutes.boutiqueForgotvarificationScreen,
          arguments: forgotEmailCtrl.text);
      loading.value = false;
      update();
    } else {
      ApiChecker.checkApi(response);
      loading.value = false;
      update();
    }
  }

  /// Boutique Forgoty Otp Verification

  var verificationLoading = false.obs;
  void boutiqueForgotOtpVerification(String email, String otp) async {
    verificationLoading.value = true;
    Map<String, dynamic> body = {'email': email, 'code': otp};
    var headers = {'Content-Type': 'application/json'};
    Response response = await ApiClient.postData(
        ApiConstant.shopperOtpVerificationPoint, jsonEncode(body),
        headers: headers);
    if (response.statusCode == 200) {

      Fluttertoast.showToast(msg: response.body['message']);
      print('Body Get:${response.body}');

      Get.toNamed(AppRoutes.boutiquesetNewPasswordScreen);
      verificationLoading.value = false;
      update();
    } else {
      ApiChecker.checkApi(response);
      verificationLoading.value = false;
      update();
    }
  }

  /// Boutique Set New password

  var setPasswordLoading = false.obs;

  void boutiqueSetNewPassword() async {
    print('PasswordCheck>:$forgotEmailCtrl');
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
      Get.offAllNamed(AppRoutes.boutiqueloginScreen);
      setPasswordLoading.value = false;
      update();
    } else {
      print('Error Chrckdfadfad>>${response.body}');
      ApiChecker.checkApi(response);
      setPasswordLoading.value = false;
      update();
    }
  }



}
