import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aidaly/models/Role/inbox_chat_model.dart';
import 'package:aidaly/service/api_check.dart';
import 'package:aidaly/service/api_client.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Utils/app_constants.dart';
import '../../helpers/prefs_helper.dart';
import '../../helpers/route.dart';
import '../../service/socket_maneger.dart';
import '../../utils/enamdata.dart';
import '../../utils/socket_constants.dart';

class InboxMassageControlelr extends GetxController {
  ScrollController scrollController = ScrollController();
  TextEditingController msgCtrl = TextEditingController();
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  RxList<InboxChatModel> chatModelList = <InboxChatModel>[].obs;

  var page = 1;
  var firstLoading = false.obs;
  var loadMoreLoading = false.obs;
  var totalPage = 0;
  var currentPage = 0;


  var firstReceiveId="".obs;
  var firstReceiveName="".obs;
  var firstReceiveImage="".obs;
  var firstReceiveRole="".obs;
  var firstChatId="".obs;

  var imagepath=''.obs;
  final ImagePicker picker = ImagePicker();
// Pick an image.

  Future<XFile?> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    imagepath.value=image!.path;
    print('Image Path>>>${imagepath.value}');
    return image;
  }

  listenMessage(String chatId) async {
    SocketApi.socket.on("sendMessage::$chatId", (data) {
      debugPrint("=========> Response Message $data");
      InboxChatModel demoData = InboxChatModel.fromJson(data['message']);
      chatModelList.add(demoData);
      chatModelList.refresh();
      update();
    });
  }
  socketOffListen(String chatId)async{
     SocketApi.socket.off("sendMessage::$chatId");
     debugPrint("Socket off New message");
  }
  sentMassage(String chatId, String receivedId, String sendId)
    async {
     var currentUserId = await PrefsHelper.getString(AppConstants.userId);
    var body={
      "text":msgCtrl.text,
      "chatId":chatId,
      "receiverId":receivedId,
      "sendId":currentUserId
    };

    print('Idddd>>>${body}');
     await SocketApi.emitWithAck(SocketConstant.sendMessageEvent,jsonEncode(body));
      chatModelList.refresh();
      msgCtrl.clear();
      update();
    scrollToEnd();
  }

  imageSent(String chatId,String recivedId)async{

    var body={
      "chatId":chatId,
      "reciverId":recivedId
    };
    List<MultipartBody> multipartBody=[MultipartBody("messageImage", File(imagepath.value))];
    var response=await ApiClient.postMultipartData(ApiConstant.imageSentEndPoint, body, multipartBody: multipartBody);
    if(response.statusCode==200){
      chatModelList.refresh();
      debugPrint("send image");
    }
  }

  firstCreeateMassage(String reciveId)async{
    var body={
      "id":reciveId
    };
    var response=await ApiClient.postData(ApiConstant.firstMassageEndPoint, jsonEncode(body));

    if(response.statusCode==200){
      firstChatId.value=response.body['data']["attributes"]["chatId"];
      firstReceiveId.value=response.body['data']["attributes"]["otherParticipant"]["_id"];
      firstReceiveName.value=response.body['data']["attributes"]["otherParticipant"]["name"];
      firstReceiveImage.value=response.body['data']["attributes"]["otherParticipant"]["image"]["publicFileUrl"];
      firstReceiveRole.value=response.body['data']["attributes"]["otherParticipant"]["role"];
      print("ChatIdddd>>>>>>>${firstReceiveId.value}");
      Get.toNamed(AppRoutes.driverChatInboxScreen,arguments: firstChatId.value,
          parameters: {
            "receiverId":firstReceiveId.value,
            "receiverName":firstReceiveName.value,
            "receiverRole":firstReceiveRole.value,
            "receiverImage":firstReceiveImage.value,
            // "currentUserId":data.first!
          });
      update();
    }
  }

  Future chatMassageFirsLoad(String roomId) async {
    firstLoading(true);
    var response = await ApiClient.getData(
        '${ApiConstant.inboxChatListEndPoint}?id=$roomId&page=$page&limit=10');
    if (response.statusCode == 200) {
      chatModelList.value = List<InboxChatModel>.from(response.body['data']
              ['attributes']
          .map((x) => InboxChatModel.fromJson(x)));
      currentPage = response.body['pagination']['attributes']['currentPage'];
      totalPage = response.body['pagination']['attributes']['totalItems'];

      debugPrint("Current Check>>${currentPage}");
      debugPrint("Total Check>>${totalPage}");
      rxRequestStatus(Status.completed);
      firstLoading(false);
      update();
    } else {
      if (ApiClient.noInternetMessage == response.statusText) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }

      ApiChecker.checkApi(response);
      firstLoading.value = false;
      update();
    }
  }

  loadMore(String roomId) async {
    debugPrint("All Check>>");
    if (firstLoading != true &&
        loadMoreLoading == false &&
        totalPage != currentPage) {
      debugPrint("All Check>>");
      page += 1;
      loadMoreLoading(true);
      var response = await ApiClient.getData(
          '${ApiConstant.inboxChatListEndPoint}?id=$roomId&page=$page&limit=10');
      if (response.statusCode == 200) {
        debugPrint("All Check>>");

        var result = List<InboxChatModel>.from(response.body['data']
                ['attributes']
            .map((x) => InboxChatModel.fromJson(x)));
        currentPage = response.body['pagination']['attributes']['currentPage'];
        totalPage = response.body['pagination']['attributes']['totalPages'];

        chatModelList.addAll(result);
        chatModelList.refresh();

        debugPrint("All Check>>${result}");
        rxRequestStatus(Status.completed);
        loadMoreLoading(false);
        update();
      } else {
        if (ApiClient.noInternetMessage == response.statusText) {
          setRxRequestStatus(Status.internetError);
        } else {
          setRxRequestStatus(Status.error);
        }
        ApiChecker.checkApi(response);
        firstLoading.value = false;
        update();
      }
    }
  }

  ///  scroll bottom and end
  scrollToEnd() {
    Timer(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate);
      }
    });
  }

  ///  scroll fast time
  scrollTime() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      scrollController.jumpTo(
        scrollController.position.minScrollExtent,
      );
    });
  }
}
