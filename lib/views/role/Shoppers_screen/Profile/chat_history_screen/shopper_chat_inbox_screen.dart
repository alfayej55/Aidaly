import 'package:aidaly/Utils/app_constants.dart';
import 'package:aidaly/models/Role/inbox_chat_model.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:aidaly/views/base/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../../../controllers/massage_controller/inbox_massage_controller.dart';
import '../../../../../helpers/prefs_helper.dart';
import '../../../../../utils/enamdata.dart';
import '../../../../base/cache_network_image.dart';

class ShopperInboxScreen extends StatefulWidget {
  ShopperInboxScreen({super.key});

  @override
  State<ShopperInboxScreen> createState() => _ShopperInboxScreenState();
}

class _ShopperInboxScreenState extends State<ShopperInboxScreen> {

  InboxMassageControlelr _chatController = Get.put(InboxMassageControlelr());
  var chatId = Get.arguments;

  var receiverId = "";
  var receiverName = "";
  var receiverImage = "";
  var receiverRole = "";
  var currentUserId = "";

  @override
  void initState() {
    receiverId = Get.parameters['receiverId']!;
    receiverName = Get.parameters['receiverName']!;
    receiverRole = Get.parameters['receiverRole']!;
    receiverImage = Get.parameters['receiverImage']!;
    getUserId();
    _chatController.listenMessage(Get.arguments);
    _chatController.chatMassageFirsLoad(chatId);

    _chatController.scrollController.addListener(() {
      if (_chatController.scrollController.position.pixels <=
          _chatController.scrollController.position.minScrollExtent) {
        debugPrint("====> scroll Bottom");
      } else if (_chatController.scrollController.position.pixels ==
          _chatController.scrollController.position.maxScrollExtent) {
        debugPrint("====> scroll Top");
        _chatController.loadMore(chatId);
      }
    });


    // TODO: implement initState
    super.initState();
  }


  @override
  void dispose() {
    _chatController.socketOffListen(chatId);
    super.dispose();
  }

  getUserId() async {
    currentUserId = await PrefsHelper.getString(AppConstants.userId);
    print('UerId>>>>$currentUserId');
    print('ReciveID>>>>$receiverId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.arrow_back,
                            size: 32,
                            color: Get.theme.primaryColor,
                          )),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    CustomNetworkImage(
                      imageUrl: '${ApiConstant.imageBaseUrl}$receiverImage',
                      //borderRadius: BorderRadius.circular(12.r),
                      height: 50.h,
                      width: 50.w,
                      boxShape: BoxShape.circle,
                      border:
                          Border.all(color: Get.theme.primaryColor, width: 2),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${receiverName}',
                          style: AppStyles.customSize(
                              size: 22, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          receiverRole.isNotEmpty? '$receiverRole':"Driver",
                          style: AppStyles.h6(
                              color: Get.theme.secondaryHeaderColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
      body: Obx(()=>_chatController.rxRequestStatus.value==Status.loading?CustomPageLoading(): Column(
        children: [
         Expanded(
           child: Stack(
             alignment: Alignment.center,
             children: [
               Obx(()=>_chatController.chatModelList.value.isNotEmpty?GroupedListView<InboxChatModel, DateTime>(
                 elements: _chatController.chatModelList,
                 controller: _chatController.scrollController,
                 padding: EdgeInsets.symmetric(horizontal: 20.w),
                 order: GroupedListOrder.DESC,
                 itemComparator: (item1, item2) =>
                     item1.createdAt!.compareTo(item2.createdAt!),
                 groupBy: (InboxChatModel message) => DateTime(
                     message.createdAt!.year,
                     message.createdAt!.month,
                     message.createdAt!.day
                 ),
                 reverse: true,
                 shrinkWrap: true,
                 // physics: const AlwaysScrollableScrollPhysics(),
                 groupSeparatorBuilder: (DateTime date) {
                   return const SizedBox();
                 },
                 itemBuilder: (context, InboxChatModel message) {
                   return message.senderId == currentUserId
                       ? senderBubble(context, message)
                       : receiverBubble(context, message);
                 },
               ):Text('Massage Empty')),

               Positioned(
                   top: 20,
                   child: Obx(
                           () => _chatController.loadMoreLoading.value
                           ? Center(child: const CustomPageLoading())
                           : const SizedBox()))
             ],
           )

         ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20),
              child: Row(
                children: [
                  ///>>>>>>>>>>>>>>>>>> Text Field >>>>>>>>>>>>>>>>>>>>
                  Expanded(
                      child: CustomTextField(
                        contentPaddingVertical: 15.h,
                        hintText: _chatController.imagepath.value.isNotEmpty?"Image": AppString.yourmessage.tr,
                        controller: _chatController.msgCtrl,
                        suffixIcon: InkWell(
                          onTap: (){
                            _chatController.pickImage();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 15.w),
                            child: SvgPicture.asset(AppIcons.fileIcon),
                          ),
                        ),
                      )),

                  ///>>>>>>>>>>>>>>>>>> Sent Button >>>>>>>>>>>>>>>>>>>>
                  InkWell(
                    onTap: (){
                      if(_chatController.imagepath.value.isNotEmpty){
                        _chatController.imageSent(chatId, receiverId);
                        _chatController.imagepath.value='';
                        print('Image Sent Image');
                      }else{
                        _chatController.sentMassage(chatId, receiverId, currentUserId);
                      }

                    },
                    child: Container(
                      height: 55.h,
                      width: 52.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10).r,
                        border: Border.all(
                            color: Get.theme.primaryColor.withOpacity(0.2)),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppIcons.sentIcon,
                          height: 24.h,
                          width: 24,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ))

    );
  }

  /// Sent Massage
  senderBubble(BuildContext context, InboxChatModel chatModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper3(
              type: BubbleType.sendBubble,
            ),
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            backGroundColor: AppColors.primaryColor,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child:
                  chatModel.messageImage !=null?CustomNetworkImage(
                      imageUrl: ApiConstant.imageBaseUrl +
                          chatModel.messageImage!.publicFileUrl!,
                      borderRadius: BorderRadius.circular(10.r),
                      height: 100,
                      width: double.infinity):
                       Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${chatModel.textMessage}',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                  AppConstants.timeAgoFormat(
                   chatModel.createdAt!),
                    // DateFormatHelper.formatTimeHHMM(chatModel.createdAt!),
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        CustomNetworkImage(
          imageUrl:
              "https://images.unsplash.com/photo-1513094735237-8f2714d57c13?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHNob3BwaW5nfGVufDB8fDB8fHww",
          height: 35,
          width: 35,
          boxShape: BoxShape.circle,
          border: Border.all(color: Get.theme.primaryColor, width: 1),
        ),
      ],
    );
  }

  /// Receive Massage
  receiverBubble(BuildContext context, InboxChatModel chatModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomNetworkImage(
          imageUrl:
          "${ApiConstant.imageBaseUrl}/$receiverImage",
          height: 35,
          width: 35,
          boxShape: BoxShape.circle,
          border: Border.all(color: Get.theme.primaryColor, width: 1),
        ),
        SizedBox(
          width: 4.w,
        ),
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper3(
              type: BubbleType.receiverBubble,
            ),
            //alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            backGroundColor: Color(0xff1E66CA).withOpacity(0.10),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child:  chatModel.messageImage !=null?CustomNetworkImage(
                  imageUrl: ApiConstant.imageBaseUrl +
                      chatModel.messageImage!.publicFileUrl!,
                  borderRadius: BorderRadius.circular(10.r),
                  height: 100,
                  width: double.infinity):

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${chatModel.textMessage}',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    AppConstants.timeAgoFormat(
                        chatModel.createdAt!),
                    // DateFormatHelper.formatTimeHHMM(chatModel.createdAt!),
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
