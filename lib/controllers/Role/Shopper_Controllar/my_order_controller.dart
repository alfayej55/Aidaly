

import 'package:aidaly/models/Role/ShopperModel/my_order_model.dart';
import 'package:aidaly/service/api_check.dart';
import 'package:aidaly/service/api_client.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class MyOrderController extends GetxController{

  @override
  void onInit() {
    myOrderGet();
    // TODO: implement onInit
    super.onInit();
  }

  var myOrderLoading=false.obs;
  RxList<ShopperMyOrderModel> myOrderModel=<ShopperMyOrderModel>[].obs;


  myOrderGet()async{
    myOrderLoading(true);
    var response=await ApiClient.getData(ApiConstant.myOrderEndPoint);
    
    if(response.statusCode==200){

      myOrderModel.value=List<ShopperMyOrderModel>.from(response.body['data']['attributes'].map((x) => ShopperMyOrderModel.fromJson(x)));
      myOrderLoading(false);
      update();

    }
    else{
      ApiChecker.checkApi(response);
      myOrderLoading(false);
    }
    
  }

}