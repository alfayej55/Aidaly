import 'dart:convert';
import 'dart:io';

import 'package:aidaly/models/Role/profile_model.dart';
import 'package:aidaly/utils/enamdata.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Utils/app_constants.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../helpers/route.dart';
import '../../../service/api_check.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';

class DriverProfileController extends GetxController {
  @override
  void onInit() {
    profiledata();
    // TODO: implement onInit
    super.onInit();
  }

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  Rx<ProfileModel> profilModel = ProfileModel().obs;

  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();

  TextEditingController oldpasswordCtrl = TextEditingController();
  TextEditingController newpassCtrl = TextEditingController();
  TextEditingController confirmpassCtrl = TextEditingController();

  File? selectedIMage;
  var imagePath = ''.obs;
  DateTime? selectedDate;

  Future pickImageFromCamera(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    selectedIMage = File(returnImage.path);
    imagePath.value = selectedIMage!.path;
    //  image = File(returnImage.path).readAsBytesSync();
    update();
    print('ImagesPath:${imagePath}');
    Get.back(); //
  }

  /// Driver Profile Data
  profiledata() async {
    var response = await ApiClient.getData(ApiConstant.profileEndPoint);
    if (response.statusCode == 200) {
      profilModel.value =
          ProfileModel.fromJson(response.body['data']['attributes']);
       rxRequestStatus(Status.completed);
      update();
    } else {
      if (ApiClient.noInternetMessage == response.statusText) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }

      ApiChecker.checkApi(response);
      update();
    }
  }

  ///  Driver  Edit Profile
  var driverProfileEditLoaditn = false.obs;
  void driverProfileEdit() async {
    driverProfileEditLoaditn.value = true;

    Map<String, String> body = {
      'name': fullNameCtrl.text,
      'email': emailCtrl.text,
      'phone': phoneCtrl.text,
      'address': addressCtrl.text,
      'city': cityCtrl.text,
      'state': stateCtrl.text,
    };

    List<MultipartBody> multipartList = [
      MultipartBody("image", File(imagePath.value))
    ];

    Response response = await ApiClient.patchMultipartData(
      ApiConstant.driverProfileEditEndPoint,
      body,
      multipartBody: imagePath.value.isEmpty ? [] : multipartList,
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);

      driverProfileEditLoaditn.value = false;
      fullNameCtrl.clear();
      emailCtrl.clear();
      addressCtrl.clear();
      cityCtrl.clear();
      stateCtrl.clear();
      Get.offAllNamed(AppRoutes.driversProfileScreen);
      update();
    } else {
      ApiChecker.checkApi(response);
      driverProfileEditLoaditn(false);
      update();
    }
  }

  /// Prpfile Change password
  var changePassLoading = false.obs;
  changePassword() async {
    changePassLoading(true);
    Map<String, dynamic> body = {
      'oldPassword': oldpasswordCtrl.text,
      "newPassword": newpassCtrl.text,
    };

    var response = await ApiClient.patchData(ApiConstant.changePasswordEndPoint,
        body: body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);
      Get.offAllNamed(AppRoutes.driversloginScreen);
      changePassLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      changePassLoading(false);
      update();
    }
  }

  /// Help and Support
  var helpSupportLoading = false.obs;
  helpAndSupport(String email, String describtion) async {
    helpSupportLoading(true);
    Map<String, dynamic> body = {
      "email": email,
      "describIssue": describtion,
    };

    var response = await ApiClient.postData(
        ApiConstant.helpSupportEndPoint, jsonEncode(body));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);
      Get.offAllNamed(AppRoutes.driversProfileScreen);
      helpSupportLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      helpSupportLoading(false);
      update();
    }
  }

  /// Driver Logout
  driverLogout() async {
    await PrefsHelper.remove(AppConstants.userRoles);
    Get.toNamed(AppRoutes.roleSelectScreen);
  }
}
