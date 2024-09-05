
import 'dart:convert';
import 'dart:io';

import 'package:aidaly/Utils/app_constants.dart';
import 'package:aidaly/helpers/prefs_helper.dart';
import 'package:aidaly/utils/enamdata.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helpers/route.dart';
import '../../../models/Role/profile_model.dart';
import '../../../service/api_check.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';
import '../../../views/role/Boutiques_screen/bottomMenu_screen/bottom_menu_screen.dart';

class BoutiqueProfileControllar extends GetxController{


  @override
  void onInit() {

    profiledata();

    // TODO: implement onInit
    super.onInit();
  }

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  Rx<ProfileModel> profilModel=ProfileModel().obs;

  TextEditingController boutiqueNameCtrl=TextEditingController();
  TextEditingController boutiqueRateCtrl=TextEditingController();
  TextEditingController emailCtrl=TextEditingController();
  TextEditingController phoneCtrl=TextEditingController();
  TextEditingController addressCtrl=TextEditingController();
  TextEditingController cityCtrl=TextEditingController();
  TextEditingController stateCtrl=TextEditingController();
  TextEditingController descriptionCtrl=TextEditingController();

  TextEditingController oldpasswordCtrl=TextEditingController();
  TextEditingController newpassCtrl=TextEditingController();
  TextEditingController confirmpassCtrl=TextEditingController();

  File? selectedIMage;
  var imagePath=''.obs;
  DateTime? selectedDate;

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


/// Profile Get data
  profiledata()async{

    var response=await ApiClient.getData(ApiConstant.profileEndPoint);
    if(response.statusCode==200){

      profilModel.value=ProfileModel.fromJson(response.body['data']['attributes']);
      rxRequestStatus(Status.completed);
      update();
    } else{

      if (ApiClient.noInternetMessage == response.statusText) {
        setRxRequestStatus(Status.internetError);
      } else
      {
        setRxRequestStatus(Status.error);
      }

      ApiChecker.checkApi(response);
      update();

    }
  }


  /// Boutiqur Profile Update
   var boutiqueLoading=false.obs;
  void boutiqueProfileEdit()async{

    boutiqueLoading(true);

    Map<String, String> body =
    {
      'name':boutiqueNameCtrl.text,
      'email':emailCtrl.text,
      'phone':phoneCtrl.text,
      'rate':boutiqueRateCtrl.text,
      'address':addressCtrl.text,
      'city':cityCtrl.text,
      'state':stateCtrl.text,
      'description':descriptionCtrl.text,
    };


    List<MultipartBody> multipartList=[
      MultipartBody(
          "image",File(imagePath.value)
      )

    ];

    Response response=await ApiClient.patchMultipartData(
      ApiConstant.driverProfileEditEndPoint,
      body,
      multipartBody:imagePath.value.isEmpty?[]:multipartList,
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg:response.body['message']);

      boutiqueNameCtrl.clear();
      emailCtrl.clear();
      phoneCtrl.clear();
      addressCtrl.clear();
      cityCtrl.clear();
      stateCtrl.clear();
      descriptionCtrl.clear();
      boutiqueRateCtrl.clear();

      Get.offAllNamed(AppRoutes.boutiqueProfileScreen);
      boutiqueLoading(false);
      update();
    } else {

      ApiChecker.checkApi(response);
      boutiqueLoading(false);
      update();
    }

  }

  /// Prpfile Change password

  var changePassLoading=false.obs;
  changePassword()async{
    changePassLoading(true);
    Map<String,dynamic> body={
      'oldPassword':oldpasswordCtrl.text,
       "newPassword":newpassCtrl.text,
    };

    var response=await ApiClient.patchData(ApiConstant.changePasswordEndPoint,body: body);
    if(response.statusCode==200){

      Fluttertoast.showToast(msg: response.body['message']);
      Get.offAllNamed(AppRoutes.boutiqueProfileScreen);
      changePassLoading(false);
      update();
    }
    else{
      ApiChecker.checkApi(response);
      changePassLoading(false);
      update();
    }
  }

/// Help and Support
  var helpSupportLoading=false.obs;
  helpAndSupport(String email,String describtion)async{

    helpSupportLoading(true);

    Map<String ,dynamic> body={

      "email":email,
      "describIssue":describtion,
    };

    var response=await ApiClient.postData(ApiConstant.helpSupportEndPoint, jsonEncode(body));
    if(response.statusCode==200){

      Fluttertoast.showToast(msg: response.body['message']);
      Get.offAllNamed(AppRoutes.boutiqueProfileScreen);
      helpSupportLoading(false);
      update();
    }
    else{

      ApiChecker.checkApi(response);
      helpSupportLoading(false);
      update();
    }
  }

/// Profile LogOut
  boutiqueLogout()async{
   await PrefsHelper.remove(AppConstants.userRoles);
   Get.toNamed(AppRoutes.roleSelectScreen);
  }

}