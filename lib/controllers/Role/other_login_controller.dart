


import 'dart:convert';
import 'dart:io';

import 'package:aidaly/service/api_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../Utils/app_constants.dart';
import '../../helpers/prefs_helper.dart';
import '../../helpers/route.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../views/base/show_toast.dart';

class OtherLoginController extends GetxController{

  RxBool googleLoginLoading = false.obs;


  var userEmail="";
  var userName="";
  var UserImage="";

  var isProfileCompletedcheck;

  /// Google Login
  void googleLogin(String role) async {

    print("Rolee>>>>>$role");

    googleLoginLoading.value=true;
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();


    try {
      var reslut = await _googleSignIn.signIn();
      if (reslut == null) {
        return;
      }
      final userData = await reslut.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult = await FirebaseAuth.instance.signInWithCredential(credential);

      userName=reslut.displayName??"";
      userEmail=reslut.email;
      UserImage=reslut.photoUrl??"";

      print("Result $reslut");
      print(reslut.displayName);
      print(reslut.email);
      print(reslut.photoUrl);
      print('Credential Token:$credential');

      ///.......... API CALL.............

      handlegoogleLogin(role);
      googleLoginLoading.value=false;
      update();

    } catch (error) {
      print("Google Error >>>>>>  $error");
    }
  }

/// Apple Sign in

   // Future<void> signInWithApple(String role) async {
  //   if (Platform.isIOS) {
  //     try {
  //       // Request Apple ID credentials
  //       final appleCredential = await SignInWithApple.getAppleIDCredential(
  //         scopes: [
  //           AppleIDAuthorizationScopes.email,
  //           AppleIDAuthorizationScopes.fullName,
  //         ],
  //       );
  //
  //       // Create an OAuth credential using the Apple ID credential
  //       final oAuthProvider = OAuthProvider("apple.com");
  //       final firebaseCredential = oAuthProvider.credential(
  //         idToken: appleCredential.identityToken,
  //         accessToken: appleCredential.authorizationCode,
  //       );
  //
  //       // Sign in to Firebase with the Apple credential
  //       UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(firebaseCredential);
  //
  //       userName=appleCredential.givenName??"";
  //       userEmail=appleCredential.email!;
  //
  //       handlegoogleLogin(role);
  //       // UserImage=appleCredential.??"";
  //       print('Successfully signed in with Apple: ${userCredential.user?.uid}');
  //
  //       // Optional: Access user's full name and email from the Apple credential
  //       print("User ID: ${userCredential.user?.uid}");
  //       print("Email: ${appleCredential.email}");
  //       print("Full Name: ${appleCredential.givenName} ${appleCredential.familyName}");
  //
  //     } catch (e) {
  //       print("Error during Apple sign-in: $e");
  //     }
  //   } else {
  //     print("Apple Sign-In is only available on iOS devices.");
  //   }
  // }

  handlegoogleLogin(String role)async{
    var fcmToken=await PrefsHelper.getString(AppConstants.fcmToken);

    Map<String, dynamic> body = {
      "email": userEmail,
      "name":userName,
      "role":role,
      "fcmToken":fcmToken
    };

    var headers = {'Content-Type': 'application/json'};

    Response response=await ApiClient.postData(
        ApiConstant.socialLoginEndPoint,
        jsonEncode(body),
        headers: headers
    );

    if(response.statusCode==200){
      await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['token']);
      await PrefsHelper.setString(AppConstants.userRoles, response.body['data']['attributes']['role']);
      await PrefsHelper.setString(AppConstants.userId, response.body['data']['attributes']['_id']);
      var userRole = response.body['data']['attributes']['role'];

      showToastMessage.showMessage('Login Successfully');
      print("Api Call Rolee>>>>>$userRole");

      if(userRole=="shopper"){
        Get.toNamed(AppRoutes.homeScreen);
      }
      else if(userRole=="boutique"){

        Get.toNamed(AppRoutes.boutiquelocationScreen);
      }else{

        Get.toNamed(AppRoutes.driversHomeScreen);

      }
    }
    else if(response.statusCode==400){
      GoogleSignIn().signOut();
      ApiChecker.checkApi(response);
    }
    else{
      debugPrint('Api Call Error');
      // debugPrint("${response.body['message']}");
      // Fluttertoast.showToast(msg:response.body['message']);
    }

    update();

  }

}