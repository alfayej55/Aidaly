

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/Role/BoutiqueModel/boutique_shopper_review_model.dart';
import '../../../service/api_check.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';
import '../../../utils/enamdata.dart';

class BoutiqueReviewController extends GetxController{

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  RxList<BoutiqueAllShopperReviewModel> boutiqueReviewModelList=<BoutiqueAllShopperReviewModel>[].obs;

  ScrollController scrollController=ScrollController();
  var page =1;
  var firstLoading=false.obs;
  var loadMoreLoading=false.obs;
  var totalPage=0;
  var currentPage=0;

  /// New Order
  Future boutiqueShopperReviewFirsLoad()async{
    firstLoading(true);
    var response=await ApiClient.getData('${ApiConstant.boutiqueShopperReviewEndPoint}?page=$page&limit=5');
    if(response.statusCode==200){
      boutiqueReviewModelList.value= List<BoutiqueAllShopperReviewModel>.from(response.body['data']['attributes'].map((x) => BoutiqueAllShopperReviewModel.fromJson(x)));
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
      var response=await ApiClient.getData('${ApiConstant.boutiqueShopperReviewEndPoint}?page=$page&limit=5');
      if(response.statusCode==200){
        var result= List<BoutiqueAllShopperReviewModel>.from(response.body['data']['attributes'].map((x) => BoutiqueAllShopperReviewModel.fromJson(x)));
         currentPage=response.body['pagination']['attributes']['currentPage'];
         totalPage=response.body['pagination']['attributes']['totalPages'];
        boutiqueReviewModelList.value.addAll(result);
        boutiqueReviewModelList.refresh();
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