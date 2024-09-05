


import 'dart:convert';

import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/models/Role/privece_policy_model.dart';
import 'package:aidaly/service/api_check.dart';
import 'package:aidaly/service/api_client.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PrivecyPolicyController extends GetxController{


  @override
  void onInit() {
    privecyPolicyGet();
    // TODO: implement onInit
    super.onInit();
  }
  var privecyLoading=false.obs;
  
  Rx<PrivecyPolicyModel> privecyModel= PrivecyPolicyModel().obs;

  privecyPolicyGet()async{
    privecyLoading(true);
    var response=await ApiClient.getData(ApiConstant.privecyPolicyEndPoint);
    if(response.statusCode==200){
      privecyModel.value=PrivecyPolicyModel.fromJson(response.body['data']['attributes'][0]);
      privecyLoading(false);
      update();
    }else{
      ApiChecker.checkApi(response);
      privecyLoading(false);
      update();
    }
  }

  var termOffUsersLoading=false.obs;

  termsOffUseAccept(String id,bool isAcceptedPrivecyPolicy,bool isAcceptedTermsAndUse)async{
    termOffUsersLoading(true);
    var body={
      "id":id,
      "isAcceptedPrivecyPolicy":isAcceptedPrivecyPolicy,
      "isAcceptedTermsAndUse":isAcceptedTermsAndUse
    };

    var responce=await ApiClient.postData(ApiConstant.acceptTermUserEndPoint, jsonEncode(body));
    if(responce.statusCode==200){
      Get.toNamed(AppRoutes.boutiqueTermAcceptSuccessScreen);
      termOffUsersLoading(false);
      update();
    }
    else{
      ApiChecker.checkApi(responce);
      termOffUsersLoading(false);
      update();
    }
  }
}