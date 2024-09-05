



import 'package:aidaly/controllers/Role/Shopper_Controllar/wishlist_controller.dart';
import 'package:aidaly/models/Role/ShopperModel/boutique_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/api_check.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';
import '../../../utils/enamdata.dart';

class ShopperBoutiqueDetailsControllar extends GetxController{
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  int page = 1;
  var isFirstLoadRunning = false.obs;
  var isLoadMoreRunning = false.obs;
  var totalPage=0;
  var currentPage=0;

   Rx<BoutiqueDetailsModel> boutiqueDetailsModel =BoutiqueDetailsModel().obs;


  /// Shopper SubCategori get
     firstLoad(String boutiqueId)async{
       page=1;
      isFirstLoadRunning(true);
    var response=await ApiClient.getData('${ApiConstant.shopProductboutiqueEndPoint}/$boutiqueId?page=$page&limit=6');
    if(response.statusCode==200){
      boutiqueDetailsModel.value= BoutiqueDetailsModel.fromJson(response.body);
      totalPage=response.body['pagination']['attributes']['totalPages'];
      currentPage=response.body['pagination']['attributes']['currentPage'];
      isFirstLoadRunning(false);
      update();
      setRxRequestStatus(Status.completed);
      update();
    }
    else if(response.statusCode==404){
      isFirstLoadRunning(false);
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
      update();

    }
  }

  /// added wish list


  final WishListController wishListController = Get.put(WishListController());

     addWishList(String productId, int index)async{
        var reponse = await wishListController.addWishListProduct(productId);
        if(reponse.runtimeType !=int){
        boutiqueDetailsModel.value.data!.attributes!.products![index].wishlist= ! boutiqueDetailsModel.value.data!.attributes!.products![index].wishlist;
        boutiqueDetailsModel.refresh();
    }
  }


}