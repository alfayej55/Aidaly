
import 'dart:convert';

import 'package:aidaly/models/Role/earn_model.dart';
import 'package:aidaly/service/api_check.dart';
import 'package:aidaly/service/api_client.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/Role/bankinfo_model.dart';
import '../../../models/Role/withdrow_model.dart';

class DriverWithdroController extends GetxController{

  TextEditingController bankNameCtrl=TextEditingController();
  TextEditingController accountNumberCtrl=TextEditingController();
  TextEditingController amoundCtrl=TextEditingController();

  Rx<EarnModel> earneModelList=EarnModel().obs;
  RxList<WithdeowModel> withrdrowModelList=<WithdeowModel>[].obs;
  RxList<BankInfoModel> newBankList=<BankInfoModel>[].obs;

  var earningLoading=false.obs;

  earnGet()async{
    earningLoading(true);
    var response=await ApiClient.getData(ApiConstant.driverEarnEndPoint);

    if(response.statusCode==200){

      earneModelList.value=EarnModel.fromJson(response.body['data']['attributes']);
      earningLoading(false);
      update();
    }else{
      ApiChecker.checkApi(response);
      earningLoading(false);
      update();
    }
  }

  var withdrowLoading=false.obs;

  withdrowAmound()async{

    withdrowLoading(true);

    var body={
      "bankName":bankNameCtrl.text,
      "bnakAccountNumber":accountNumberCtrl.text,
      "withdrowAmount":amoundCtrl.text
    };

    var response=await ApiClient.postData(ApiConstant.withdroEndPoint, jsonEncode(body));

    if(response.statusCode==200){
      getWithdrowAmound();
      Get.back();
      withdrowLoading(false);
    }
    else{
      ApiChecker.checkApi(response);
      withdrowLoading(false);
    }

  }

  getWithdrowAmound()async{
    earningLoading(true);
    var response=await ApiClient.getData(ApiConstant.showAllWithdrowEndPoint);

    if(response.statusCode==200){
      withrdrowModelList.value= List<WithdeowModel>.from(response.body['data']['attributes'].map((x) => WithdeowModel.fromJson(x)));
      earningLoading(false);
      update();

    }else{
      ApiChecker.checkApi(response);
      earningLoading(false);
      update();
    }
  }



  /// Driver Add Bank

  var bankLoading=false.obs;

  addBank()async{
    bankLoading(true);

    var body={
      "bankName":bankNameCtrl.text,
      "accountNumber":accountNumberCtrl.text,
    };

    var response= await ApiClient.postData(ApiConstant.boutiqueAddNewBankEndPoint, jsonEncode(body));
    if(response.statusCode==200){
      newBankInfo();
      Get.back();
      bankLoading(false);
      update();
    }else{
      ApiChecker.checkApi(response);
      bankLoading(false);
      update();
    }
  }


  var bankinfoLoading=false.obs;

  newBankInfo()async{
    bankinfoLoading(true);

    var response=await ApiClient.getData(ApiConstant.boutiqueShowBankOfuserEndPoint);
    if(response.statusCode==200){
      newBankList.value=List<BankInfoModel>.from(response.body['data']['attributes'].map((x) => BankInfoModel.fromJson(x)));
      bankinfoLoading(false);
      update();
    }else{
      ApiChecker.checkApi(response);
      bankinfoLoading(false);
      update();
    }
  }
}