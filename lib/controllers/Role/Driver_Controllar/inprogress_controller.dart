


import 'package:aidaly/models/Role/DriverModel/order_model.dart';
import 'package:aidaly/service/api_check.dart';
import 'package:aidaly/utils/enamdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/Role/DriverModel/order_details_model.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';

class DriverInprogressController extends GetxController{


  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  RxList<DriverOrderModel> inProgressOrderModel=<DriverOrderModel>[].obs;

  ScrollController scrollController=ScrollController();
  var page =1;
  var firstLoading=false.obs;
  var loadMoreLoading=false.obs;
  var totalPage=0;
  var currentPage=0;

  Future deiverInprogressFirsLoad()async{
    firstLoading(true);
    var response=await ApiClient.getData('${ApiConstant.driverInprogressEndPoint}?page=$page&limit=5');
    if(response.statusCode==200){
      inProgressOrderModel.value= List<DriverOrderModel>.from(response.body['data']['attributes'].map((x) => DriverOrderModel.fromJson(x)));
      currentPage=response.body['pagination']['attributes']['currentPage'];
      totalPage=response.body['pagination']['attributes']['totalPages'];
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

    }

  }

  loadMore()async{
    if(firstLoading !=true &&loadMoreLoading ==false && totalPage !=currentPage){
      page +=1;
      loadMoreLoading (true);
      var response=await ApiClient.getData('${ApiConstant.driverInprogressEndPoint}?page=$page&limit=5');
      if(response.statusCode==200){
        var result= List<DriverOrderModel>.from(response.body['data']['attributes'].map((x) => DriverOrderModel.fromJson(x)));
        currentPage=response.body['pagination']['attributes']['currentPage'];
        totalPage=response.body['pagination']['attributes']['totalPages'];
        inProgressOrderModel.value.addAll(result);
        inProgressOrderModel.refresh();
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


  Rx<DriverOrderDetailsModel> inprogressDetailsModel=DriverOrderDetailsModel().obs;
  var detailsLoading=false.obs;

  driverInProgressDetails(String productId)async{

    detailsLoading.value=true;
    var response=await ApiClient.getData('${ApiConstant.driverinProgressDetailsEndPoint}/$productId');
    if(response.statusCode==200){
      inprogressDetailsModel.value=DriverOrderDetailsModel.fromJson(response.body['data']['attributes']);
      detailsLoading.value=false;
      update();
    }

    else
    {
      ApiChecker.checkApi(response);
      detailsLoading.value=false;
      update();
    }

  }







}