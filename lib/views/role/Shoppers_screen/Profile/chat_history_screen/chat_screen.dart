import 'package:aidaly/Utils/app_constants.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/Role/Shopper_Controllar/message_controller.dart';
import '../../../../../controllers/massage_controller/massage_controller.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../base/cache_network_image.dart';
import 'innerWidget/chat_cart.dart';

class ChatHistoryScreen extends StatefulWidget {
  ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  MassageController _massageListCtrl = Get.put(MassageController());

  @override
  void initState() {
    super.initState();
    _massageListCtrl.massageListFirsLoad();
    _massageListCtrl.scrollController.addListener(_scrollListener);

  }

  void _scrollListener() {
    if (_massageListCtrl.scrollController.position.pixels ==
        _massageListCtrl.scrollController.position.maxScrollExtent) {
      _massageListCtrl.loadMore();
      print('Load More Check');
    }
  }

  @override
  void dispose() {
    _massageListCtrl.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            AppString.chathistoryText.tr,
            style: AppStyles.h2(color: Get.theme.primaryColor),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.arrow_back,
                size: 25,
                color: Get.theme.primaryColor,
              )),
        ),
      ),
      body: Obx(() => _massageListCtrl.firstLoading.value
          ? Center(child: CustomPageLoading()):_massageListCtrl.massageListModel.value.isEmpty?
      Center(child: Text("No one has messaged you",style: AppStyles.h3(),))
          : Column(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    _massageListCtrl.refressLoad();
                  },
                  child: ListView.separated(
                    itemCount:
                        _massageListCtrl.massageListModel.value.length + 1,
                    controller: _massageListCtrl.scrollController,
                    shrinkWrap: true,
                    primary: false,
                    //   scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (index >=
                          _massageListCtrl.massageListModel.value.length) {
                        return _massageListCtrl.firstLoading.value
                            ? CustomPageLoading()
                            : SizedBox();
                      } else {
                        var data =
                            _massageListCtrl.massageListModel.value[index];
                        return GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: ListTile(
                                onTap: () {
                                  Get.toNamed(AppRoutes.shopperInboxScreen,arguments: data.chatId,
                                  parameters: {
                                    "receiverId":data.otherParticipantId!.id!,
                                    "receiverName":data.otherParticipantId!.name!,
                                    "receiverRole":data.otherParticipantId!.role!,
                                    "receiverImage":data.otherParticipantId!.image!.publicFileUrl!,
                                   // "currentUserId":data.otherParticipantId!
                                  });
                                },
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 24.w),
                                titleTextStyle: AppStyles.customSize(
                                    size: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor),
                                subtitleTextStyle: AppStyles.h6(
                                    color: AppColors.secandaryTextColor),
                                leading: CustomNetworkImage(
                                  imageUrl:
                                      '${ApiConstant.imageBaseUrl}${data.otherParticipantId!.image!.publicFileUrl}',
                                  //borderRadius: BorderRadius.circular(12.r),
                                  height: 60.h,
                                  width: 60.w,
                                  boxShape: BoxShape.circle,
                                ),
                                title: Text(
                                  '${data.otherParticipantId!.name}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${data.lastMessage}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      AppConstants.timeAgoFormat(
                                          data.updatedAt!),
                                      style: TextStyle(
                                          color: AppColors.subTextColor),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Colors.black,
                                  size: 22,
                                )),
                          ),
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ),
                ),

                // ListView.separated(
                //   itemCount: _chatCtrl.chatList.length,
                //   shrinkWrap: true,
                //   primary: false,
                //   itemBuilder: (context,index){
                //     var data=_chatCtrl.chatList[index];
                //     return ListTile(
                //         onTap: (){
                //           Get.toNamed(AppRoutes.shopperInboxScreen,arguments: data.id,
                //               parameters: {
                //                 "receiverId":data.pid!.id!,
                //                 "receiverName":data.pid!.name!,
                //                 "receiverImage":data.pid!.image!.publicFileUrl!,
                //                 "currentUserId":data.sid!
                //               });
                //         },
                //         contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
                //         titleTextStyle: AppStyles.customSize(
                //             size: 16,
                //             fontWeight: FontWeight.w600,
                //             color: AppColors.textColor),
                //         subtitleTextStyle:
                //         AppStyles.h6(color: AppColors.secandaryTextColor),
                //         leading: CustomNetworkImage(
                //           imageUrl:'${ApiConstant.imageBaseUrl}${data.pid!.image!.publicFileUrl}',
                //           //borderRadius: BorderRadius.circular(12.r),
                //           height: 60.h,
                //           width: 60.w,
                //           boxShape: BoxShape.circle,
                //         ),
                //         title: Text('${data.pid!.name}',overflow: TextOverflow.ellipsis,maxLines: 1,),
                //         subtitle: Column(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text('${data.lastmessag![0].text}',overflow: TextOverflow.ellipsis,maxLines: 1,),
                //             Text(AppConstants.timeAgoFormat(data.lastmessag![0].createdAt!),style: TextStyle(color: AppColors.subTextColor),),
                //           ],
                //         ),
                //         trailing: Icon(Icons.arrow_forward_ios_sharp,color:Colors.black,size:22,));
                //   },
                //   separatorBuilder: (context,index){
                //     return Divider();
                //   },
                // )
              ],
            )),
    );
  }
}
