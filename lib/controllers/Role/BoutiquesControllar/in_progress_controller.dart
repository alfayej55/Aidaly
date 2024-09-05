
import 'package:aidaly/models/Role/BoutiqueModel/all_driver_model.dart';
import 'package:aidaly/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../helpers/route.dart';
import '../../../models/Role/BoutiqueModel/boutique_order_model.dart';
import '../../../models/Role/BoutiqueModel/boutique_progress_order_model_details.dart';
import '../../../service/api_check.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';
import '../../../utils/enamdata.dart';

class InProgressController extends GetxController{

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  RxList<BoutiqueOrderModel> newOrderModel=<BoutiqueOrderModel>[].obs;

  ScrollController scrollController=ScrollController();
  var page =1;
  var firstLoading=false.obs;
  var loadMoreLoading=false.obs;
  var totalPage=0;
  var currentPage=0;

  Future inProgressOrderFirsLoad()async{
    firstLoading(true);
    var response=await ApiClient.getData('${ApiConstant.boutiqueInProgressOrderEndPoint}?page=$page&limit=5');
    if(response.statusCode==200){
      newOrderModel.value= List<BoutiqueOrderModel>.from(response.body['data']['attributes'].map((x) => BoutiqueOrderModel.fromJson(x)));
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
      var response=await ApiClient.getData('${ApiConstant.boutiquenewOrderEndPoint}?page=$page&limit=5');
      if(response.statusCode==200){
        var result= List<BoutiqueOrderModel>.from(response.body['data']['attributes'].map((x) => BoutiqueOrderModel.fromJson(x)));
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

/// InProgress Details
  Rx<InProgressDetails> inprogressDetailsModel=InProgressDetails().obs;
  var detailsLoading=false.obs;
  inProgressDetails(String productId)async{

    detailsLoading.value=true;

    var response=await ApiClient.getData('${ApiConstant.boutiqueInProgressDetailsOrderEndPoint}/$productId');
    if(response.statusCode==200){
      inprogressDetailsModel.value=InProgressDetails.fromJson(response.body['data']['attributes']);
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



  /// All Driver List
  RxList<AllDriverListModel> allDriverModel=<AllDriverListModel>[].obs;

  var driverLoading=false.obs;

  allDriverList()async{
     driverLoading.value=true;
    var response = await ApiClient.getData(ApiConstant.boutiqueAllDriverEndPoint);
    if(response.statusCode==200){
      allDriverModel.value=List<AllDriverListModel>.from(response.body['data']['attributes'].map((x) => AllDriverListModel.fromJson(x)));
      driverLoading.value=false;
      update();
    }
    else{
      print('Error${response.body}');
    }

  }

  /// Assign To Driver

  var assignToDriverLoading=false.obs;
  RxInt currentIndex= 0.obs;
  RxString drivarId=''.obs;

  ordertAssignToDriver(String inprogressId)async{

    if(drivarId.value != null){
      assignToDriverLoading.value=true;
      var response=await ApiClient.patchData('${ApiConstant.boutiqueDriverAssignEndPoint}/$inprogressId?driverId=${drivarId.value}');
      if(response.statusCode==200){
        print('Assign to Driver');
        assignToDriverLoading.value=false;
        Get.offAllNamed(AppRoutes.allOrdertBoutiqueScreen);
        update();
      }else{
        ApiChecker.checkApi(response);
        assignToDriverLoading.value=false;
        update();
      }
    }
    else{
      Fluttertoast.showToast(msg: 'Please Select Driver');
    }

  }


}