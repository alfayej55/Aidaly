import 'dart:convert';

import 'package:aidaly/controllers/Role/Shopper_Controllar/shop_controller.dart';
import 'package:aidaly/models/Role/ShopperModel/wishlist_folder_model.dart';
import 'package:aidaly/service/api_check.dart';
import 'package:aidaly/service/api_client.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../helpers/route.dart';
import '../../../models/Role/ShopperModel/shop_subcategori_model.dart';
import '../../../models/Role/ShopperModel/wishlist_model.dart';
import '../../../utils/enamdata.dart';

class WishListController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  ScrollController scrollController = ScrollController();

  int page = 1;
  var isFirstLoadRunning = false.obs;
  var isLoadMoreRunning = false.obs;
  var totalPage = 0;
  var currentPage = 0;

  TextEditingController createWishListCtrl = TextEditingController();
   RxList selectedList = [].obs;

  RxList<WishListModel> wishListModel = <WishListModel>[].obs;
  RxList<WishListFolderModel> wishListFolderModel = <WishListFolderModel>[].obs;


  RxList wishlistFolderName=[].obs;
  var wishListname=''.obs;


  ///  added wishlist
  Future<dynamic> addWishListProduct(String productId) async {
    var body = {"productId": productId};
    var response = await ApiClient.postData(
        ApiConstant.wishListAddEndPoint, jsonEncode(body));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);
      return response.body;
    } else {
      ApiChecker.checkApi(response);
      return 1;
    }
  }

  /// WishList Get
  wishListFirstLoad() async {
    isFirstLoadRunning(true);
    var response = await ApiClient.getData('${ApiConstant.allWishListGetEndPoint}?page=$page&limit=5');
    if (response.statusCode == 200) {
      wishListModel.value = List<WishListModel>.from(response.body['data']['attributes'].map((x) => WishListModel.fromJson(x)));
      totalPage = response.body['pagination']['attributes']['totalPages'];
      currentPage = response.body['pagination']['attributes']['currentPage'];
      wishListModel.refresh();
      isFirstLoadRunning(false);
      setRxRequestStatus(Status.completed);
      update();
    }
    else if(response.statusCode==404){
      wishListModel.clear();
      isFirstLoadRunning(false);
      update();
    }
    else {
      if (ApiClient.noInternetMessage == response.statusText) {
        setRxRequestStatus(Status.internetError);

      }
      else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
      isFirstLoadRunning(false);
      update();
    }
  }

  refreshLoad() async {
    page = 1;
    isFirstLoadRunning(true);
    var response = await ApiClient.getData(
        '${ApiConstant.allWishListGetEndPoint}?page=$page&limit=5');
    if (response.statusCode == 200) {
      wishListModel.value = List<WishListModel>.from(response.body['data']
              ['attributes']
          .map((x) => WishListModel.fromJson(x)));
      totalPage = response.body['pagination']['attributes']['totalPages'];
      currentPage = response.body['pagination']['attributes']['currentPage'];
      print('jbhkasdhadjfjad');
      isFirstLoadRunning(false);
      update();
      setRxRequestStatus(Status.completed);
      update();
    } else if (response.statusCode == 404) {
      isFirstLoadRunning(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      isFirstLoadRunning(false);
      update();
    }
  }

  loadMore() async {
    if (isFirstLoadRunning.value != true &&
        isLoadMoreRunning.value == false &&
        totalPage != currentPage) {
      isLoadMoreRunning(true);
      page += 1;

      var response = await ApiClient.getData(
          '${ApiConstant.allWishListGetEndPoint}?page=$page&limit=5');
      if (response.statusCode == 200) {
        var result = List<WishListModel>.from(response.body['data']
                ['attributes']
            .map((x) => WishListModel.fromJson(x)));
        totalPage = response.body['pagination']['attributes']['totalPages'];
        currentPage = response.body['pagination']['attributes']['currentPage'];
        wishListModel.value.addAll(result);
        wishListModel.refresh();
        isLoadMoreRunning(false);
      } else {
        ApiChecker.checkApi(response);
        isLoadMoreRunning(false);
      }
    }
  }


  /// Wish List Collection
  void toggleSelection(String id){
    if (selectedList.contains(id)) {
      selectedList.remove(id.toString());
      selectedList.refresh();
    } else {
      selectedList.add(id.toString());
      selectedList.refresh();
    }

    debugPrint(selectedList.value.length.toString());
  }


  var wishListLoading = false.obs;
/// WishList Folder Create
   wishListCollectionCreate(String type) async {
    wishListLoading(true);
    print('CollectionListCheck>>${selectedList.value}');
    List<Map<String, String>> collectionOfProducts = [];

    for (var data in selectedList.value) {
      if (data != null) {
        // Ensure data is not null

        if(type=='collection'){
          collectionOfProducts.add({"collection": data});
        }else{
          collectionOfProducts.add({"wishlistId": data});
        }

      }
    }

    var body = {
      "wishlistTitle": createWishListCtrl.text,
      "collectionOfProducts": collectionOfProducts,
      "collectionType":type
    };

    var response = await ApiClient.postData(
        ApiConstant.createWishListCollectionEndPoint, jsonEncode(body));
    if (response.statusCode == 200) {

         createWishListCtrl.clear();
         selectedList.clear();
         wishListFirstLoad();
         //Get.toNamed(AppRoutes.wishListFolderScreen);
        wishListLoading(false);
         Get.back();
      update();
    } else {
      ApiChecker.checkApi(response);
      wishListLoading(false);
      update();
    }
  }

  /// WishList Folder Name
  var folderLoading=false.obs;
    wishListFolderName()async{
      folderLoading(true);
     var response=await ApiClient.getData(ApiConstant.wishListFolderNameEndPoint);

     if(response.statusCode==200){
       wishlistFolderName.value=response.body["data"]['attributes'];
       wishListname.value= wishlistFolderName[0];
       wishListFolder(wishListname.value);
       folderLoading(false);
       wishlistFolderName.refresh();
       update();
     }
     else if(response.statusCode==404){
       wishlistFolderName.clear();
       wishListFolderModel.clear();

       folderLoading(false);
     }
     else{
       ApiChecker.checkApi(response);
       folderLoading(false);
       update();
     }}

    var wishListFolderLoading=false.obs;

    var collectionType="";
   wishListFolder(String folderName)async{

    var response=await ApiClient.getData('${ApiConstant.wishListFolderEndPoint}?name=$folderName');
    if(response.statusCode==200){

      wishListFolderModel.value= List<WishListFolderModel>.from(response.body['data']['attributes']["collectionOfProducts"]!.map((x) => WishListFolderModel.fromJson(x)));
      collectionType=response.body["data"]["attributes"]["collectionType"];
      print("Collection Type>>>$collectionType");
      wishlistFolderName.refresh();
      update();
    }
    else if(response.statusCode==404){
      folderLoading(false);
      update();

    }
    else{

      debugPrint('Error');
      ApiChecker.checkApi(response);
      wishListFolderLoading(false);
      update();

    }


  }

}
