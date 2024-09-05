
import 'package:aidaly/service/api_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/Role/BoutiqueModel/boutique_order_assigned_model.dart';
import '../../../models/Role/BoutiqueModel/boutique_order_model.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';
import '../../../utils/enamdata.dart';

class OrderAssignedController extends GetxController{


  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  RxList<BoutiqueOrderAssignedModel> orderAssignedModel=<BoutiqueOrderAssignedModel>[].obs;

  ScrollController scrollController=ScrollController();
  var page =1;
  var firstLoading=false.obs;
  var loadMoreLoading=false.obs;
  var totalPage=0;
  var currentPage=0;

  Future boutiquAssignedFirsLoad()async{
    firstLoading(true);
    var response=await ApiClient.getData('${ApiConstant.boutiqueOrderAssignEndPoint}?page=$page&limit=5');
    if(response.statusCode==200){
      orderAssignedModel.value= List<BoutiqueOrderAssignedModel>.from(response.body['data']['attributes'].map((x) => BoutiqueOrderAssignedModel.fromJson(x)));
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
        var result= List<BoutiqueOrderAssignedModel>.from(response.body['data']['attributes'].map((x) => BoutiqueOrderAssignedModel.fromJson(x)));
        currentPage=response.body['pagination']['attributes']['currentPage'];
        totalPage=response.body['pagination']['attributes']['totalPages'];
        orderAssignedModel.value.addAll(result);
        orderAssignedModel.refresh();
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