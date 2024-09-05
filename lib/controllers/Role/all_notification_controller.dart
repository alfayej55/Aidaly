
import 'package:aidaly/models/Role/all_notification_model.dart';
import 'package:aidaly/service/api_client.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/utils/enamdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/api_check.dart';


class AllNotificationController extends GetxController{


  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  RxList<AllNotificationModel> notificationModelList=<AllNotificationModel>[].obs;

  ScrollController scrollController=ScrollController();
  var page =1;
  var firstLoading=false.obs;
  var loadMoreLoading=false.obs;
  var totalPage=0;
  var currentPage=0;



  Future notificationFirstLoad()async{
    firstLoading(true);
    var response=await ApiClient.getData('${ApiConstant.notificationEndPoint}?page=$page&limit=5');
    if(response.statusCode==200){
      notificationModelList.value= List<AllNotificationModel>.from(response.body['data']['attributes'].map((x) => AllNotificationModel.fromJson(x)));
      currentPage=response.body['pagination']['attributes']['currentPage'];
      totalPage=response.body['pagination']['attributes']['totalPages'];

      debugPrint("Current Check>>${currentPage}");
      debugPrint("Total Check>>${totalPage}");
      rxRequestStatus(Status.completed);
      firstLoading(false);
      update();
    } else{
      if (ApiClient.noInternetMessage == response.statusText) {
        setRxRequestStatus(Status.internetError);

      } else
      {
        setRxRequestStatus(Status.error);
      }

      ApiChecker.checkApi(response);
      firstLoading.value=false;
      update();

    }}

  loadMore()async{
    if(firstLoading !=true &&loadMoreLoading ==false && totalPage !=currentPage){
      page +=1;
      loadMoreLoading (true);
      var response=await ApiClient.getData('${ApiConstant.notificationEndPoint}?page=$page&limit=5');
      if(response.statusCode==200){

        debugPrint("All Check>>");

        var result= List<AllNotificationModel>.from(response.body['data']['attributes'].map((x) => AllNotificationModel.fromJson(x)));
        currentPage=response.body['pagination']['attributes']['currentPage'];
        totalPage=response.body['pagination']['attributes']['totalPages'];

        notificationModelList.value.addAll(result);
        notificationModelList.refresh();

        debugPrint("All Check>>${result}");
        rxRequestStatus(Status.completed);
        loadMoreLoading(false);
        update();
      }
      else{
        if (ApiClient.noInternetMessage == response.statusText) {
          setRxRequestStatus(Status.internetError);
        } else
        {
          setRxRequestStatus(Status.error);
        }
        ApiChecker.checkApi(response);
        firstLoading.value=false;
        update();
      }

    }
  }






}
