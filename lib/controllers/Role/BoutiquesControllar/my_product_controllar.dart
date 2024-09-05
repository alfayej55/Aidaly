

import 'package:aidaly/models/Role/BoutiqueModel/myproduct_model.dart';
import 'package:get/get.dart';

import '../../../service/api_check.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';
import '../../../utils/enamdata.dart';

class BoutiqueMyProductControllar extends GetxController{
    @override
  void onInit() {
      boutiquemyProduct();
    super.onInit();
  }

  final rxRequestStatus = Status.loading.obs;
  RxBool isLoading=false.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  Rx<BoutiqueMyProductModel> myProductModel=BoutiqueMyProductModel().obs;

  boutiquemyProduct()async{

    var response=await ApiClient.getData(ApiConstant.boutiqueMyProdyctEndPoint);
    if(response.statusCode==200){
      myProductModel.value=BoutiqueMyProductModel.fromJson(response.body);
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


}