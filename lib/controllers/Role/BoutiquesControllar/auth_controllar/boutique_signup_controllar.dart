

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Utils/app_constants.dart';
import '../../../../helpers/prefs_helper.dart';
import '../../../../helpers/push_notification_helpers.dart';
import '../../../../helpers/route.dart';
import '../../../../service/api_check.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_constants.dart';

class BoutiqueSignUpControllar extends GetxController{

  TextEditingController boutiqueNameCtrl=TextEditingController();
  TextEditingController boutiqueRateCtrl=TextEditingController();
  TextEditingController emailCtrl=TextEditingController();
  TextEditingController passwordCtrl=TextEditingController();
  TextEditingController confirmCtrl=TextEditingController();
  TextEditingController phoneCtrl=TextEditingController();
  TextEditingController addressCtrl=TextEditingController();
  TextEditingController cityCtrl=TextEditingController();
  TextEditingController stateCtrl=TextEditingController();
  TextEditingController descriptionCtrl=TextEditingController();
  File? selectedIMage;
  var imagePath=''.obs;
  var signUpLoading = false.obs;

  RxDouble latitude=0.0.obs;
  RxDouble longitude=0.0.obs;



  ///  Boutique sign up
  void boutiqueSingUp()async{

    signUpLoading.value=true;
    NotificationHelper.getFcmToken();
    var fcmToken=await PrefsHelper.getString(AppConstants.fcmToken);

    Map<String, String> body =
    {
      'name':boutiqueNameCtrl.text,
      'email':emailCtrl.text,
      'password':passwordCtrl.text,
      'phone':phoneCtrl.text,
      'rate':boutiqueRateCtrl.text,
      'address':addressCtrl.text,
      'city':cityCtrl.text,
      'state':stateCtrl.text,
      'description':descriptionCtrl.text,
      'role':'boutique',
      "fcmToken":fcmToken
    };

    var headers = {'Content-Type': 'multipart/form-data'};
    List<MultipartBody> multipartList=[

      MultipartBody("image",File(imagePath.value))

    ];

    Response response=await ApiClient.postMultipartData(
        ApiConstant.boutiqueSignUpEndPoint,
        body,
        multipartBody:imagePath.value.isEmpty?[]:multipartList,
        headers: headers
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg:response.body['message']);
      Get.toNamed(AppRoutes.boutiquevarificationScreen,arguments:emailCtrl.text);
      boutiqueNameCtrl.clear();
      emailCtrl.clear();
      passwordCtrl.clear();
      confirmCtrl.clear();
      phoneCtrl.clear();
      addressCtrl.clear();
      cityCtrl.clear();
      stateCtrl.clear();
      descriptionCtrl.clear();
      boutiqueRateCtrl.clear();
      signUpLoading.value=false;
      update();

    } else {

      print('Error>>${response.body['message']}');
      // Fluttertoast.showToast(msg:response.body['message']);
      ApiChecker.checkApi(response);
      signUpLoading(false);
      update();
    }

  }


  /// Boutique Otp Verification
  var verificationLoading=false.obs;
  void boutiqueOtpVerification(String email, String otp)async{

    verificationLoading.value=true;
    Map <String ,dynamic> body={
      'email':email,
      'code':otp
    };
    var headers = {'Content-Type': 'application/json'};
    Response response=await ApiClient.postData(ApiConstant.shopperOtpVerificationPoint, jsonEncode(body),headers: headers);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg:response.body['message']);
      await  PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['attributes']['accessToken']);
      await PrefsHelper.setString(AppConstants.userId, response.body['data']['attributes']['id']);
      Get.toNamed(AppRoutes.boutiquelocationScreen);
      verificationLoading.value=false;
      update();

    }
    else{
      ApiChecker.checkApi(response);

      verificationLoading.value=false;
      update();
    }
  }


  /// Boutique Resent otp
  var resentOtpLoading=false.obs;
  void boutiqueResentOtp(String email)async{

    resentOtpLoading.value=true;
    Map <String ,dynamic> body={
      'email':email
    };

    Response response=await ApiClient.postData(ApiConstant.shopperResentOtpEndPoint, jsonEncode(body));

    if(response.statusCode==200){
      Fluttertoast.showToast(msg:response.body['message']);

      resentOtpLoading.value=false;
      update();
    }
    else{

      ApiChecker.checkApi(response);
      resentOtpLoading.value=false;
      update();

    }
  }

  /// Boutique Set Location
  void boutiqueSetLocation()async{
    Map <String ,dynamic> body={
      'latitude':latitude.value,
      'longitude':longitude.value
    };
    Response response=await ApiClient.postData(ApiConstant.shopperSetLocationEndPoint, jsonEncode(body));
    if(response.statusCode==200){

      Fluttertoast.showToast(msg:response.body['message']);
      // PrefsHelper.setString(AppConstants.bearerToken, response.body[''])
      Get.toNamed(AppRoutes.boutiqueaccountSuccessScreen);

      update();

    }
    else{
      ApiChecker.checkApi(response);
      update();
    }
  }


  Future getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        var  locationMessage = 'Location permissions are denied.';
        return locationMessage;

      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latitude.value=position.latitude;
      longitude.value=position.longitude;

      print('Latitude :${latitude.value}');
      print('Longitude :${longitude.value}');

      update();

    } catch (e) {

    }

  }

  Future pickImageFromCamera(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    selectedIMage = File(returnImage.path);
    imagePath.value=selectedIMage!.path;
    //  image = File(returnImage.path).readAsBytesSync();
    update();
    print('ImagesPath:${imagePath}');
    Get.back(); //
  }
}