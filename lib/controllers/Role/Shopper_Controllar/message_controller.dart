//
//
// import 'package:aidaly/service/api_constants.dart';
// import 'package:get/get.dart';
//
// import '../../../models/Role/message_list_model.dart';
// import '../../../service/api_client.dart';
//
// class ShopperMessageController extends GetxController{
//   RxList<MessageListModel> chatList=<MessageListModel>[].obs;
//
//   var messageListloading = false.obs;
//
//   getChatList()async {
//     messageListloading(true);
//     var response = await ApiClient.getData(ApiConstant.messageListEndPoint);
//     if(response.statusCode==200){
//       chatList.value= List<MessageListModel>.from(response.body['data']['attributes'].map((x) => MessageListModel.fromJson(x)));
//       messageListloading(false);
//       update();
//     }else{
//       messageListloading(false);
//     }
//   }
//
//
//
// }