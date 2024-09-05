
 import 'dart:convert';

import 'package:aidaly/models/Role/BoutiqueModel/boutique_dashboard_model.dart';
import 'package:aidaly/service/api_client.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../../../Utils/app_constants.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../helpers/route.dart';
import '../../../models/Role/BoutiqueModel/boutique_order_model.dart';
import '../../../service/api_check.dart';
import '../../../utils/enamdata.dart';
import '../../../models/Role/BoutiqueModel/boutique_order_details_model.dart';

class NewOrderController extends GetxController{

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  RxList<BoutiqueOrderModel> newOrderModel=<BoutiqueOrderModel>[].obs;

  ScrollController scrollController=ScrollController();
  var page =1;
  var firstLoading=false.obs;
  var loadMoreLoading=false.obs;
  var totalPage=0;
  var currentPage=0;

  @override
  void onInit() {

    boutiqueDashBoard();

    // TODO: implement onInit
    super.onInit();

  }

/// Boutique DashBoard

  Rx<BoutiqueDashBoardModel> dashBoardModel=BoutiqueDashBoardModel().obs;
  var dashboardLoading=false.obs;
     boutiqueDashBoard()async{
    // dashboardLoading.value=true;
    var response=await ApiClient.getData(ApiConstant.boutiqueDashBoardEndPoint);
    if(response.statusCode==200){
      dashBoardModel.value=BoutiqueDashBoardModel.fromJson(response.body['data']['attributes']);
      rxRequestStatus(Status.completed);
     // dashboardLoading.value=false;
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
  
  
/// New Order
  Future boutiqueNewOrderFirsLoad()async{
     firstLoading(true);
    var response=await ApiClient.getData('${ApiConstant.boutiquenewOrderEndPoint}?page=$page&limit=5');
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


  /// Order Product Details
  Rx<BoutiqueOrderDetailsModel> productDetailsModel=BoutiqueOrderDetailsModel().obs;
  var detailsLoading=false.obs;

  boutiqueorderDetails(String productId)async{

     detailsLoading.value=true;
    var response=await ApiClient.getData('${ApiConstant.boutiqueOrderDetailsEndPoint}/$productId');
    if(response.statusCode==200){
      productDetailsModel.value=BoutiqueOrderDetailsModel.fromJson(response.body);
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

var acceptLoading=false.obs;

 Future newOrderAccept(String productId)async{
    acceptLoading.value=true;

  var  bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken'
    };

    try{
      var response=await http.patch(Uri.parse('${ApiConstant.baseUrl}${ApiConstant.boutiqueNewOrderAcceptEndPoint}/$productId'),headers: headers);
      if(response.statusCode==200){
        print('dada>>>>${response.body}');
        Get.offAllNamed(AppRoutes.allOrdertBoutiqueScreen);
        acceptLoading.value=false;
        update();
        //Fluttertoast.showToast(msg:response.body['status']);
      }

    }catch(e){
      acceptLoading.value=false;
      update();
      update();
      print('Error>>$e');
    }
  }






}