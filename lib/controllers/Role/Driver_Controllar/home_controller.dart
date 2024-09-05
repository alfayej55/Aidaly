
import 'package:aidaly/models/Role/DriverModel/order_model.dart';
import 'package:aidaly/models/Role/dashboard_model.dart';
import 'package:aidaly/service/api_check.dart';
import 'package:aidaly/utils/enamdata.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../helpers/push_notification_helpers.dart';
import '../../../models/Role/BoutiqueModel/boutique_order_details_model.dart';
import '../../../models/Role/DriverModel/new_order_details.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';

class DriverHomeController extends GetxController{


  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  RxList<DriverOrderModel> newOrderModel=<DriverOrderModel>[].obs;
  Rx<DashBoardModel> dashBoardModel=DashBoardModel().obs;

  ScrollController scrollController=ScrollController();
  var page =1;
  var firstLoading=false.obs;
  var loadMoreLoading=false.obs;
  var totalPage=0;
  var currentPage=0;

  @override
  void onInit() {
  //  NotificationHelper.notificationPermission();
    // TODO: implement onInit

    super.onInit();
  }


///  Driver New Order Call


  var dashboardLoading=false.obs;

  driverDashBoard()async{

   dashboardLoading(true);

    var response=await ApiClient.getData(ApiConstant.driverDashBoardEndPoint);
    if(response.statusCode==200){
      dashBoardModel.value=DashBoardModel.fromJson(response.body['data']['attributes']);
      dashboardLoading(false);
      update();

    }

    else{
      print('DeshBoard Check>>${response.body}');
      ApiChecker.checkApi(response);
      detailsLoading(false);
      update();
    }
    
  }
  
  
  Future deiverNewOrderFirsLoad()async{
    firstLoading(true);
    var response=await ApiClient.getData('${ApiConstant.drivernewOrderEndPoint}?page=$page&limit=5');
    if(response.statusCode==200){
      newOrderModel.value= List<DriverOrderModel>.from(response.body['data']['attributes'].map((x) => DriverOrderModel.fromJson(x)));
      currentPage=response.body['pagination']['attributes']['currentPage'];
      totalPage=response.body['pagination']['attributes']['totalPages'];
      rxRequestStatus(Status.completed);
      firstLoading(false);

      update();
    } else{
      if (ApiClient.noInternetMessage == response.statusText) {
        setRxRequestStatus(Status.internetError);
      }
      else
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
      var response=await ApiClient.getData('${ApiConstant.drivernewOrderEndPoint}?page=$page&limit=5');
      if(response.statusCode==200){
        var result= List<DriverOrderModel>.from(response.body['data']['attributes'].map((x) => DriverOrderModel.fromJson(x)));
        currentPage=response.body['pagination']['attributes']['currentPage'];
        totalPage=response.body['pagination']['attributes']['totalPages'];
        newOrderModel.value.addAll(result);
        newOrderModel.refresh();
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


  /// Order Product Details
  Rx<DriverNewOrderDetailsModel> productDetailsModel=DriverNewOrderDetailsModel().obs;
  var detailsLoading=false.obs;

  driverorderDetails(String productId)async{
    detailsLoading.value=true;
    var response=await ApiClient.getData('${ApiConstant.drivernewOrderDetailsEndPoint}/$productId');
    if(response.statusCode==200){
      productDetailsModel.value=DriverNewOrderDetailsModel.fromJson(response.body);
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

/// Driver Order Accept
  var acceptOrderLoading=false.obs;

  driverOderAccept(String orderId)async{

    acceptOrderLoading.value=true;

    var response=await  ApiClient.patchData('${ApiConstant.drivernewOrderAcceptEndPoint}/$orderId');
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: response.body['message']);
      acceptOrderLoading.value=false;
      update();
      Get.back();
    }

    else
    {
      ApiChecker.checkApi(response);
      acceptOrderLoading.value=false;
      update();
    }

  }

  var cancelOrderLoading=false.obs;

  driverCencelOrder(String id)async{
    cancelOrderLoading.value=true;
    var body={};
    var response=await ApiClient.postData('${ApiConstant.drivernewOrderCencellEndPoint}/$id', body);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: response.body['message']);
      cancelOrderLoading.value=false;
      update();
      Get.back();
    }
    else
    {
      ApiChecker.checkApi(response);
      cancelOrderLoading.value=false;
      update();
    }
  }





}