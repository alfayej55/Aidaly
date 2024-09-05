import 'package:aidaly/controllers/Role/all_notification_controller.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/dimensions.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../../models/Role/all_notification_model.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/style.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  AllNotificationController _notificationCtrl= Get.put(AllNotificationController());

  @override
  void initState() {
    _notificationCtrl.notificationFirstLoad();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            AppString.notificationText.tr,
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

      body: Obx(()=>_notificationCtrl.firstLoading.value ? CustomPageLoading():
          _notificationCtrl.notificationModelList.isEmpty?Center(child: Text("You Have No Notifications",style: AppStyles.h3(),)):
      GroupedListView<AllNotificationModel, String>(
        elements: _notificationCtrl.notificationModelList.value,
        groupBy: (element) => groupByDate(element.createdAt!), // Access the 'group' field directly
        groupSeparatorBuilder: (String groupByValue) => Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(groupByValue, style: AppStyles.customSize(size: 14)),
            )),
        itemBuilder: (context, AllNotificationModel element) {
          return Column(
            children: [
              ListTile(
                leading: Container(
                  height: 63.h,
                  width: 63.w,
                  decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    shape: BoxShape.circle,
                    boxShadow: [AppStyles.boxShadow],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppImages.notificationimage,
                      height: 25.h,
                      width: 26.w,
                    ),
                  ),
                ),
                titleTextStyle: AppStyles.h6(color: AppColors.textColor),
                title: Text(element.title!), // Access the 'title' field directly
                subtitle: Text('${DateFormat('hh:mm a').format(element.createdAt!)}'),
                subtitleTextStyle: AppStyles.h6(color: AppColors.textColor.withOpacity(0.5)),
              ),
              Divider(
                thickness: 0.2,
                indent: 34.w,
                endIndent: 34.w,
                color: AppColors.textColor.withOpacity(0.4),
              ),
            ],
          );
        },
        //  itemComparator: (item1, item2) => item1.name.compareTo(item2.name), // Access the 'name' field directly
        useStickyGroupSeparators: true,
        floatingHeader: true,
        order: GroupedListOrder.ASC,
      ))

      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 30.w),
      //       child: Text(
      //         'Today',
      //         style: AppStyles.customSize(size: 14),
      //       ),
      //     ),
      //     SizedBox(
      //       height: Dimensions.paddingSizeDefault,
      //     ),
      //
      //     ///>>>>>>>>>>>>>>>>> Notification Text  >>>>>>>>>>>>>>>>>>>>>>
      //
      //     ListTile(
      //       // contentPadding: EdgeInsets.symmetric(horizontal: 10),
      //       leading: Container(
      //         height: 63.h,
      //         width: 63.w,
      //         decoration: BoxDecoration(
      //             color: Get.theme.cardColor,
      //             shape: BoxShape.circle, boxShadow: [AppStyles.boxShadow]),
      //         child: Center(child: SvgPicture.asset(AppImages.notificationimage,height: 25.h,width: 26.w,)),
      //       ),
      //
      //       titleTextStyle: AppStyles.h6(color: AppColors.textColor),
      //       title: Text(
      //            'New items is here in the app check and find your choice variety',
      //       ),
      //       subtitle: Text('11:12 AM'),
      //       subtitleTextStyle:
      //           AppStyles.h6(color: AppColors.textColor.withOpacity(0.5)),
      //     ),
      //
      //     SizedBox(
      //       height: Dimensions.paddingSizeminiSmall.h,
      //     ),
      //
      //     ///>>>>>>>>>>>>>>>>> Divider >>>>>>>>>>>>>>>>>>>>>>
      //     Divider(
      //       thickness: 0.2,
      //       indent: 34.w,
      //       endIndent: 34.w,
      //       color: AppColors.textColor.withOpacity(0.4),
      //     ),
      //
      //     ListTile(
      //       // contentPadding: EdgeInsets.symmetric(horizontal: 10),
      //       leading: Container(
      //         height: 63.h,
      //         width: 63.w,
      //         decoration: BoxDecoration(
      //             color: Get.theme.cardColor,
      //             shape: BoxShape.circle, boxShadow: [AppStyles.boxShadow]),
      //         child: Center(child: SvgPicture.asset(AppImages.notificationimage,height: 25.h,width: 26.w,)),
      //       ),
      //
      //       titleTextStyle: AppStyles.h6(color: AppColors.textColor),
      //       title: Text(
      //         'New items is here in the app check and find your choice variety',
      //       ),
      //       subtitle: Text('11:12 AM'),
      //       subtitleTextStyle:
      //       AppStyles.h6(color: AppColors.textColor.withOpacity(0.5)),
      //     ),
      //   ],
      // ),
    );
  }

  String groupByDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final notificationDate = DateTime(date.year, date.month, date.day);

    if (notificationDate == today) {
      return 'Today';
    } else if (notificationDate == today.subtract(Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return 'Earlier';
    }
  }
}
