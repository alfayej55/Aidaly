


import 'dart:convert';

import 'package:aidaly/controllers/Role/Shopper_Controllar/wishlist_controller.dart';
import 'package:aidaly/models/Role/ShopperModel/shop_subcategori_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../models/Role/ShopperModel/shop_model.dart';
import '../../../service/api_check.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';
import '../../../utils/enamdata.dart';

class ShopController extends GetxController{

  @override
  void onInit() {
    shopCatgegori();
    // TODO: implement onInit
    super.onInit();
  }

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;


   Rx<ShopCategoryModel> shopCategoriModel=ShopCategoryModel().obs;
  RxList<ShopperProductModel> shopSubCategoriModel=<ShopperProductModel>[].obs;

/// Shopper  Shop Categori Get
  shopCatgegori()async{

    var response=await ApiClient.getData(ApiConstant.shopCategoriEndPoint);
    if(response.statusCode==200){
      shopCategoriModel.value=ShopCategoryModel.fromJson(response.body);
      setRxRequestStatus(Status.completed);
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

  var subCategoriLoading=false.obs;
  int page = 1;
  var isFirstLoadRunning = false.obs;
  var isLoadMoreRunning = false.obs;
  var totalPage=0;
  var currentPage=0;

/// Shopper SubCategori get
  subCategoryFirstLoad(String categoriName)async{
    page=1;
    isFirstLoadRunning(true);
    var response=await ApiClient.getData('${ApiConstant.shopSubCategoriEndPoint}/$categoriName?page=$page&limit=5');
    if(response.statusCode==200){
      shopSubCategoriModel.value= List<ShopperProductModel>.from(response.body['data']['attributes'].map((x) => ShopperProductModel.fromJson(x)));
      totalPage=response.body['pagination']['attributes']['totalPages'];
      currentPage=response.body['pagination']['attributes']['currentPage'];

      shopSubCategoriModel.refresh();
      isFirstLoadRunning(false);
      update();
      setRxRequestStatus(Status.completed);
      subCategoriLoading.value=false;
      update();
    }
    else if(response.statusCode==404){
      shopSubCategoriModel.clear();
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
      subCategoriLoading.value=false;
      update();
    }
  }

  refreshLoad(String categoriName)async{
    page=1;
    isFirstLoadRunning(true);
    var response=await ApiClient.getData('${ApiConstant.shopSubCategoriEndPoint}/$categoriName?page=$page&limit=5');
    if(response.statusCode==200){

      shopSubCategoriModel.value= List<ShopperProductModel>.from(response.body['data']['attributes'].map((x) => ShopperProductModel.fromJson(x)));
      totalPage=response.body['pagination']['attributes']['totalPages'];
      currentPage=response.body['pagination']['attributes']['currentPage'];
      print('jbhkasdhadjfjad');
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
      ApiChecker.checkApi(response);
      isFirstLoadRunning(false);
      update();

    }
  }

  loadMore(String categoriName) async {
  debugPrint("========> load more");
  if (isFirstLoadRunning.value != true &&
      isLoadMoreRunning.value == false &&
      totalPage != currentPage) {
    isLoadMoreRunning(true);
    page += 1;
    debugPrint("========> ${page}");
    var response=await ApiClient.getData('${ApiConstant.shopSubCategoriEndPoint}/$categoriName?page=$page&limit=5');
    if (response.statusCode == 200) {

     var result= List<ShopperProductModel>.from(response.body['data']['attributes'].map((x) => ShopperProductModel.fromJson(x)));
     debugPrint("========> ${result}");
      totalPage=response.body['pagination']['attributes']['totalPages'];
      currentPage=response.body['pagination']['attributes']['currentPage'];
       shopSubCategoriModel.value.addAll(result);
      shopSubCategoriModel.refresh();
      isLoadMoreRunning(false);
    } else {

      ApiChecker.checkApi(response);
      isLoadMoreRunning(false);

    }}}


  ///  added wish list

final WishListController wishListController = Get.put(WishListController());
  addWishList(String productId,int index)async{
    var reponse = await wishListController.addWishListProduct(productId);
    if(reponse.runtimeType !=int){
      shopSubCategoriModel[index].wishlist = !shopSubCategoriModel[index].wishlist;
      shopSubCategoriModel.refresh();

    }
  }

}