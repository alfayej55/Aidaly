import 'dart:convert';

import 'package:aidaly/controllers/Role/Shopper_Controllar/wishlist_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../Utils/app_constants.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../helpers/push_notification_helpers.dart';
import '../../../models/Role/ShopperModel/shop_model.dart';
import '../../../models/Role/ShopperModel/shopper_home_model.dart';
import '../../../models/Role/profile_model.dart';
import '../../../service/api_check.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';
import '../../../utils/enamdata.dart';

class HomeController extends GetxController  implements GetxService{

  String title="Home Screen";

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  RxList<ShopperHomeModel> homeModel=<ShopperHomeModel>[].obs;

  ScrollController scrollController=ScrollController();
  var page =1;
  var firstLoading=false.obs;
  var loadMoreLoading=false.obs;
  var totalPage=0;
  var currentPage=0;

  /// filter Section

  RxList<bool> select = <bool>[].obs;
  RxList selected = [].obs;

  var startPrice=0.0.obs;
  var endPrice=1000.0.obs;

  @override
  void onInit() {
  //  NotificationHelper.notificationPermission();

    getCurrentLocation();

    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    debugPrint("On onReady  $title");
    super.onReady();
  }
  

  Future shopperHomeFirsLoad()async{
    page=1;
    firstLoading(true);

    var urlEndPoint='${ApiConstant.shopperHomeEndPoint}?page=$page&limit=5';
    if(selected.isNotEmpty){
      urlEndPoint='${ApiConstant.shopperHomeEndPoint}?categories=${jsonEncode(selected)}&minPrice=$startPrice&maxPrice=$endPrice&page=$page&limit=5';
    }
    else if(startPrice !=0.0 || endPrice != 1000.0){
      urlEndPoint='${ApiConstant.shopperHomeEndPoint}?minPrice=$startPrice&maxPrice=$endPrice&page=$page&limit=5';
    }

    var response=await ApiClient.getData(urlEndPoint);
    if(response.statusCode==200){
      homeModel.value= List<ShopperHomeModel>.from(response.body['data']['attributes'].map((x) => ShopperHomeModel.fromJson(x)));
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

    }

  }

  loadMore()async{
    if(firstLoading !=true &&loadMoreLoading ==false && totalPage !=currentPage){
      page +=1;
      loadMoreLoading (true);
      var response=await ApiClient.getData('${ApiConstant.shopperHomeEndPoint}?page=$page&limit=5');
      if(response.statusCode==200){

        debugPrint("All Check>>");

        var result= List<ShopperHomeModel>.from(response.body['data']['attributes'].map((x) => ShopperHomeModel.fromJson(x)));
        currentPage=response.body['pagination']['attributes']['currentPage'];
        totalPage=response.body['pagination']['attributes']['totalPages'];

        homeModel.value.addAll(result);
        homeModel.refresh();

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

  Future refressLoad()async{
    page=1;
    firstLoading(true);
    var response=await ApiClient.getData('${ApiConstant.shopperHomeEndPoint}?page=$page&limit=5');
    if(response.statusCode==200){
      homeModel.value= List<ShopperHomeModel>.from(response.body['data']['attributes'].map((x) => ShopperHomeModel.fromJson(x)));
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

    }

  }

  /// Product Search

  RxList<ProfileModel> profileListModel=<ProfileModel>[].obs;
  var searchLoading=false.obs;

  searchProduct(String productName)async{
    searchLoading(true);
    var response=await ApiClient.getData('${ApiConstant.shopperSearchEndPoint}?name=$productName');
    if(response.statusCode==200){
      profileListModel.value= List<ProfileModel>.from(response.body['data']['attributes'].map((x) => ProfileModel.fromJson(x)));
      searchLoading(false);
      update();
    } else if(response.statusCode==404){
      profileListModel.clear();
      profileListModel.refresh();
      searchLoading(false);
    }
    else{
      ApiChecker.checkApi(response);
      searchLoading(false);
      update();

    }
  }


  Future getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        var  locationMessage = 'Location permissions are denied.';
        return locationMessage;
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      await PrefsHelper.setDouble(AppConstants.shopperLat,position.latitude);
      await PrefsHelper.setDouble(AppConstants.shopperLag,position.longitude);
      update();
    } catch (e) {
    }


  }


  ///Filter Catagori


  Rx<ShopCategoryModel> filterCategoriModel=ShopCategoryModel().obs;

 var filterLoading=false.obs;
  /// Shopper  Shop Categori Get
  filtertCatgegori()async{
    filterLoading(true);
    var response=await ApiClient.getData(ApiConstant.shopperFilterCategoriEndPoint);
    if(response.statusCode==200){
      filterCategoriModel.value=ShopCategoryModel.fromJson(response.body);
      filterLoading(false);
      update();
    }
    else{

      ApiChecker.checkApi(response);
      filterLoading(false);
      update();

    }
  }

  WishListController wishListCtrl=Get.put(WishListController());

  addWishlist(String id, int index)async{

  var response= await wishListCtrl.addWishListProduct(id);

    if(response.runtimeType !=int){
     // homeModel.value[index].wishlist =! homeModel.value[index].wishlist;
      homeModel.refresh();
    }

  }
}