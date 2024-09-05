
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/Role/message_list_model.dart';
import '../../service/api_check.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../utils/enamdata.dart';

class MassageController extends GetxController{
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  RxList<MassageListModel> massageListModel=<MassageListModel>[].obs;

  ScrollController scrollController=ScrollController();
  var page =1;
  var firstLoading=false.obs;
  var loadMoreLoading=false.obs;
  var totalPage=0;
  var currentPage=0;

  Future massageListFirsLoad()async{
    firstLoading(true);
    var response=await ApiClient.getData('${ApiConstant.massageListEndPoint}?page=$page&limit=5');
    if(response.statusCode==200){
      massageListModel.value= List<MassageListModel>.from(response.body['data']['attributes'].map((x) => MassageListModel.fromJson(x)));
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
      var response=await ApiClient.getData('${ApiConstant.massageListEndPoint}?page=$page&limit=5');
      if(response.statusCode==200){

        debugPrint("All Check>>");

        var result= List<MassageListModel>.from(response.body['data']['attributes'].map((x) => MassageListModel.fromJson(x)));
        currentPage=response.body['pagination']['attributes']['currentPage'];
        totalPage=response.body['pagination']['attributes']['totalPages'];

        massageListModel.value.addAll(result);
        massageListModel.refresh();

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
    var response=await ApiClient.getData('${ApiConstant.massageListEndPoint}?page=$page&limit=5');
    if(response.statusCode==200){
      massageListModel.value= List<MassageListModel>.from(response.body['data']['attributes'].map((x) => MassageListModel.fromJson(x)));
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



}