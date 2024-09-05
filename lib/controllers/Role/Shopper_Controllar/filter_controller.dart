//
//
//  import 'package:get/get.dart';
//
// import '../../../models/Role/ShopperModel/shop_model.dart';
// import '../../../service/api_check.dart';
// import '../../../service/api_client.dart';
// import '../../../service/api_constants.dart';
// import '../../../utils/enamdata.dart';
//
// class FilterController extends GetxController{
//
//   final rxRequestStatus = Status.loading.obs;
//   void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
//
//   Rx<ShopCategoryModel> filterCategoriModel=ShopCategoryModel().obs;
//
//   /// Shopper  Shop Categori Get
//   filtertCatgegori()async{
//
//     var response=await ApiClient.getData(ApiConstant.shopperFilterCategoriEndPoint);
//     if(response.statusCode==200){
//       filterCategoriModel.value=ShopCategoryModel.fromJson(response.body);
//       setRxRequestStatus(Status.completed);
//       update();
//     }
//     else{
//       if (ApiClient.noInternetMessage == response.statusText) {
//         setRxRequestStatus(Status.internetError);
//       } else
//       {
//         setRxRequestStatus(Status.error);
//       }
//       ApiChecker.checkApi(response);
//       update();
//
//     }
//   }
// }