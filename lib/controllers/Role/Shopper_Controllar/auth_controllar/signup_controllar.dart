
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aidaly/Utils/app_constants.dart';
import 'package:aidaly/helpers/prefs_helper.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../helpers/push_notification_helpers.dart';
import '../../../../service/api_check.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_constants.dart';


class RegisterControllar extends GetxController{
  TextEditingController fullNameCtrl=TextEditingController();
  TextEditingController emailCtrl=TextEditingController();
  TextEditingController phoneNumberCtrl=TextEditingController();
  TextEditingController addressCtrl=TextEditingController();
  TextEditingController passwordCtrl=TextEditingController();
  TextEditingController confirmpasswordCtrl=TextEditingController();
  TextEditingController cityCtrl=TextEditingController();
  TextEditingController stateCtrl=TextEditingController();
  RxDouble latitude=0.0.obs;
  RxDouble longitude=0.0.obs;

  var signUpLoading = false.obs;
  File? selectedIMage;
  var imagePath=''.obs;
  RxString selectedDate='Select Date Time'.obs;

///  ShopperModel sign up

  void shopperSingUp()async{
     signUpLoading.value=true;
     NotificationHelper.getFcmToken();
     var fcmToken=await PrefsHelper.getString(AppConstants.fcmToken);

    Map<String, String> body = {
      'name':fullNameCtrl.text,
      'email':emailCtrl.text,
      'password':passwordCtrl.text,
      'dateOfBirth':selectedDate.value,
      'phone':phoneNumberCtrl.text,
      'address':addressCtrl.text,
      'city':cityCtrl.text,
      'state':stateCtrl.text,
      'role':'shopper',
      "fcmToken":fcmToken
    };

    var headers = {'Content-Type': 'multipart/form-data'};
    List<MultipartBody> multipartList=[
      MultipartBody("image",File(imagePath.value))
    ];

    Response response=await ApiClient.postMultipartData(
        ApiConstant.shopperSignUpEndPoint,
        body,
        multipartBody:imagePath.value.isEmpty?[]:multipartList,
        headers: headers
    );

    if (response.statusCode == 200) {

      Fluttertoast.showToast(msg:response.body['message']);

      Get.toNamed(AppRoutes.shopperverificationScreen,arguments:emailCtrl.text);
      fullNameCtrl.clear();
      emailCtrl.clear();
      passwordCtrl.clear();
      confirmpasswordCtrl.clear();
      selectedDate.value='';
      phoneNumberCtrl.clear();
      addressCtrl.clear();
      cityCtrl.clear();
      stateCtrl.clear();
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

 /// ShopperModel Otp Verification
  var verificationLoading=false.obs;
  void shopperOtpVerification(String email, String otp)async{

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
      Get.toNamed(AppRoutes.locationScreen);
      verificationLoading.value=false;
      update();

    }
    else{
      ApiChecker.checkApi(response);

      verificationLoading.value=false;
      update();
    }
  }

  /// ShopperModel Resent otp
  var resentOtpLoading=false.obs;
  void shopperResentOtp(String email)async{

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

 /// ShopperModel Set Location
  void shopperSetLocation()async{
    Map <String ,dynamic> body={
      'latitude':latitude.value,
      'longitude':longitude.value
    };
    Response response=await ApiClient.postData(ApiConstant.shopperSetLocationEndPoint, jsonEncode(body));
    if(response.statusCode==200){

      Fluttertoast.showToast(msg:response.body['message']);
      // PrefsHelper.setString(AppConstants.bearerToken, response.body[''])
      Get.toNamed(AppRoutes.accountSuccessScreen);

      update();

    }
    else{
      ApiChecker.checkApi(response);
      update();
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

  Future<void> selectDate(BuildContext context ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1725),
        lastDate: DateTime(2050)
    );

    if (picked != null && picked != selectedDate) {
      selectedDate.value=DateFormat('dd/MM/yyyy').format(picked);
      print('dateTime:${selectedDate}');

      update();
    }
  }



/// User Current Location
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

      await PrefsHelper.setDouble(AppConstants.shopperLat,position.latitude);
      await PrefsHelper.setDouble(AppConstants.shopperLag,position.longitude);

      print('Latitude :${latitude.value}');
      print('Longitude :${longitude.value}');

      update();

    } catch (e) {

    }

  }

}